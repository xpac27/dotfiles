#!/usr/bin/env python3
"""Live Wayland regression checks; temporarily replaces both text selections."""

import os
import fcntl
from pathlib import Path
import pty
import select
import signal
import struct
import subprocess
import tempfile
import termios
import time


PROVIDER = Path(__file__).resolve().parents[1] / '.vim/plugin/wayland-clipboard.vim'


def run(*args, **kwargs):
    # wl-copy forks a clipboard server which may retain inherited output FDs.
    # Wait for the launcher, not EOF from that long-lived server.
    if 'wl-copy' in args:
        return subprocess.run(args, stdout=subprocess.DEVNULL,
                              stderr=subprocess.DEVNULL, timeout=5, **kwargs)
    return subprocess.run(args, capture_output=True, timeout=10, **kwargs)


def clipboard(primary=False):
    args = ['timeout', '3s', 'wl-paste', '--no-newline',
            '--type', 'text/plain;charset=utf-8']
    if primary:
        args.append('--primary')
    result = run(*args)
    if result.returncode == 124:
        raise AssertionError('Clipboard owner did not respond')
    if result.returncode != 0:
        assert b'Nothing is copied' in result.stderr, result.stderr
        return None
    return result.stdout


def wait_for(condition, master, description):
    deadline = time.monotonic() + 5
    output = b''
    while time.monotonic() < deadline:
        if condition():
            return
        ready, _, _ = select.select([master], [], [], 0.05)
        if ready:
            try:
                chunk = os.read(master, 65536)
                output += chunk
                # Fish and Vim query the terminal before accepting input.
                if b'\x1b[0c' in chunk or b'\x1b[c' in chunk:
                    os.write(master, b'\x1b[?1;2c')
                if b'\x1b[?u' in chunk:
                    os.write(master, b'\x1b[?0u')
                if b'\x1b[>0q' in chunk:
                    os.write(master, b'\x1bP>|test terminal\x1b\\')
                if b'\x1b]11;?' in chunk:
                    os.write(master, b'\x1b]11;rgb:0000/0000/0000\x1b\\')
                if b'\x1bP+q' in chunk:
                    os.write(master, b'\x1bP0+r\x1b\\')
            except OSError:
                pass
    raise AssertionError(f'{description}: {output[-2000:]!r}')


def stopped(pid):
    return '\nState:\tT' in Path(f'/proc/{pid}/status').read_text()


def check_registers(directory):
    errors = directory / 'errors'
    script = directory / 'registers.vim'
    script.write_text(fr"""set shell=/bin/fish
source {PROVIDER}
set clipboard=unnamed,unnamedplus
call assert_equal('wl_clipboard', v:clipmethod)
source {PROVIDER}
call assert_equal(1, count(split(&clipmethod, ','), 'wl_clipboard'))
for reg in ['+', '*']
    for sample in [[['char'], 'v'], [['first', ''], 'v'],
                \ [['alpha', '', 'beta'], 'V'], [['ab', 'cd'], "\<C-V>2"]]
        call setreg(reg, sample[0], sample[1])
        call assert_equal(sample[0], getreg(reg, 1, 1))
        call assert_equal(sample[1], getregtype(reg))
    endfor
endfor
call system("wl-copy --type 'text/plain;charset=utf-8'", "external\n\n")
call assert_equal(['external', ''], getreg('+', 1, 1))
call assert_equal('V', getregtype('+'))
call system("wl-copy --type 'text/plain;charset=utf-8'", 'other selection')
call assert_equal('other selection', getreg('+'))
call assert_equal('v', getregtype('+'))
call setline(1, ['ordinary yank'])
normal! ggyy
call assert_equal("ordinary yank\n", getreg('+'))
call assert_equal("ordinary yank\n", getreg('*'))
normal! ggdd
call assert_equal("ordinary yank\n", getreg('+'))
call system('wl-copy --clear')
call assert_equal('', getreg('+'))
call writefile(v:errors, '{errors}')
if !empty(v:errors)
    cquit
endif
qa!
""")
    result = run('vim', '-Nu', 'NONE', '-n', '-i', 'NONE', '-es', '-S', str(script))
    assert result.returncode == 0, (result.stderr, errors.read_text() if errors.exists() else '')
    assert errors.read_text() == '', errors.read_text()
    print('PASS: register types, external changes, normal yanks/deletes, empty clipboard, reload')


def check_suspend(directory):
    ready = directory / 'ready'
    script = directory / 'suspend.vim'
    script.write_text(f"""set shell=/bin/fish
source {PROVIDER}
set clipboard=unnamed,unnamedplus
call setline(1, ['wayland-suspend-regression'])
normal! ggyy
call writefile([string(getpid()), v:clipmethod], '{ready}')
""")
    shell, master = pty.fork()
    if shell == 0:
        os.environ['TERM'] = 'xterm-256color'
        os.execlp('fish', 'fish', '--no-config', '--interactive',
                  '--init-command', "set -g fish_history ''")
    fcntl.ioctl(master, termios.TIOCSWINSZ, struct.pack('HHHH', 24, 80, 0, 0))
    vim_pid = None
    try:
        os.write(master, f'vim -Nu NONE -n -i NONE -S {script}\n'.encode())
        wait_for(ready.exists, master, 'Vim did not initialize')
        pid, method = ready.read_text().splitlines()
        vim_pid = int(pid)
        assert method == 'wl_clipboard', method
        os.write(master, b'\x1a')
        wait_for(lambda: stopped(vim_pid), master, 'Ctrl+Z did not suspend Vim')
        for primary in (False, True):
            assert clipboard(primary) == b'wayland-suspend-regression\n'
        assert stopped(vim_pid), 'Vim resumed during the paste checks'
        print('PASS: real Ctrl+Z in fish; both selections paste while Vim is stopped')
        # An outside copy must survive both suspension and resumption.
        assert run('timeout', '3s', 'wl-copy', '--type', 'text/plain;charset=utf-8',
                   input=b'newer outside copy').returncode == 0
        os.write(master, b'fg\n')
        wait_for(lambda: not stopped(vim_pid), master, 'fg did not resume Vim')
        assert clipboard() == b'newer outside copy'
        os.write(master, b':qa!\r')
        wait_for(lambda: not Path(f'/proc/{vim_pid}').exists(), master, 'Vim did not exit')
        assert clipboard() == b'newer outside copy'
        assert clipboard(True) == b'wayland-suspend-regression\n'
        print('PASS: outside copy survives fg; Vim-owned text survives Vim exit')
    finally:
        for pid in (vim_pid, shell):
            if pid is not None:
                try:
                    os.kill(pid, signal.SIGCONT)
                    os.kill(pid, signal.SIGTERM)
                except ProcessLookupError:
                    pass
        os.close(master)
        os.waitpid(shell, 0)


def check_unavailable_and_timeout(directory):
    script = directory / 'fallback.vim'
    errors = directory / 'fallback-errors'
    script.write_text(f"""let before = &clipmethod
source {PROVIDER}
call assert_equal(before, &clipmethod)
call assert_false(has_key(v:clipproviders, 'wl_clipboard'))
call writefile(v:errors, '{errors}')
if !empty(v:errors)
    cquit
endif
qa!
""")
    env = dict(os.environ, WAYLAND_DISPLAY='')
    result = run('vim', '-Nu', 'NONE', '-n', '-i', 'NONE', '-es',
                 '-S', str(script), env=env)
    assert result.returncode == 0, errors.read_text()

    tools = directory / 'bin'
    tools.mkdir()
    reader = tools / 'wl-paste'
    reader.write_text('#!/bin/sh\nsleep 10\n')
    reader.chmod(0o755)
    errors = directory / 'timeout-errors'
    script = directory / 'timeout.vim'
    script.write_text(f"""set shell=/bin/fish
source {PROVIDER}
call setreg('+', 'stale text', 'v')
let start = reltime()
call assert_equal('', getreg('+'))
call assert_true(reltimefloat(reltime(start)) < 5.0)
call assert_match('Wayland clipboard read failed or timed out', execute('messages'))
call writefile(v:errors, '{errors}')
if !empty(v:errors)
    cquit
endif
qa!
""")
    env = dict(os.environ, PATH=str(tools) + os.pathsep + os.environ['PATH'])
    result = run('vim', '-Nu', 'NONE', '-n', '-i', 'NONE', '-es',
                 '-S', str(script), env=env)
    assert result.returncode == 0, errors.read_text()
    print('PASS: native fallback outside Wayland; stalled reader times out without stale paste')


def main():
    assert os.environ.get('WAYLAND_DISPLAY'), 'Run inside a Wayland session'
    original = [clipboard(primary) for primary in (False, True)]
    try:
        with tempfile.TemporaryDirectory(prefix='vim-wayland-test-') as name:
            directory = Path(name)
            check_registers(directory)
            check_suspend(directory)
            check_unavailable_and_timeout(directory)
    finally:
        for primary, content in zip((False, True), original):
            args = ['timeout', '3s', 'wl-copy', '--type', 'text/plain;charset=utf-8']
            if primary:
                args.append('--primary')
            if content is None:
                args.append('--clear')
            result = run(*args, input=content)
            assert result.returncode == 0, result.stderr


if __name__ == '__main__':
    main()
