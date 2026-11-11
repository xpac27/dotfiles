function vpn --description 'Connect to NordVPN: se (default), fr, uk, us, pl; off or status'
    set -l countries se fr uk us pl
    set -l units
    for country in $countries
        set -a units openvpn-client@nordvpn-$country.service
    end

    if test (count $argv) -gt 1
        echo 'Usage: vpn [se|fr|uk|us|pl|off|status]' >&2
        return 2
    end

    set -l action se
    if set -q argv[1]
        set action $argv[1]
    end

    switch $action
        case -h --help help
            echo 'vpn                   Connect to Sweden (default)'
            echo 'vpn se|fr|uk|us|pl     Connect or switch country'
            echo 'vpn off               Disconnect'
            echo 'vpn status            Show service state (not a public-IP check)'
        case off
            # Batched stops use broader authorization on newer systemd.
            # Keep each request within our per-unit Polkit permissions.
            set -l result 0
            for unit in $units
                command systemctl stop $unit
                set -l stop_status $status
                if test $result -eq 0; and test $stop_status -ne 0
                    set result $stop_status
                end
            end
            return $result
        case status
            command systemctl --no-pager --plain list-units --all $units
        case '*'
            if not contains -- $action $countries
                echo 'Unknown country. Use se, fr, uk, us or pl.' >&2
                return 2
            end
            # Installed systemd conflicts stop the previous tunnel first.
            command systemctl start openvpn-client@nordvpn-$action.service
    end
end
