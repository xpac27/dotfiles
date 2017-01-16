-- Perfect for Dell XPS 15 9530 with Ubuntu
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
 
import XMonad
import System.Exit




import XMonad
-- Prompt
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.AppendFile (appendFilePrompt)
-- -- Hooks
import XMonad.Operations

import System.IO
import System.Exit

import XMonad.Util.Run


import XMonad.Actions.CycleWS

 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageHelpers
import Graphics.X11.ExtraTypes.XF86
import Data.List
import XMonad.Actions.CopyWindow

import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.Minimize
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
 
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "gnome-terminal"

-- Width of the window border in pixels.
--
myBorderWidth = 1
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod1Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5"]
 
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#222222"
myFocusedBorderColor = "#ebac54"
 
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ 

    -- launch a terminal
    ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run -fn -bitstream-*-*-*-*-*-16-*-*-*-*-*-*-*")

    -- launch gmrun
    -- , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window 
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    -- , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_o     ), windows W.focusMaster  )

    --minimize winwdows
    -- , ((modm,               xK_m     ), withFocused minimizeWindow)
    -- , ((modm .|. shiftMask, xK_m     ), sendMessage RestoreNextMinimizedWin)

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap (used with avoidStruts from Hooks.ManageDocks)
    , ((modm , xK_b ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), restart "xmonad" True)

    --lock screen
    , ((modm .|. shiftMask, xK_l ), spawn "xscreensaver-command -lock")

    -- Shrink tile
    , ((modm, xK_a), sendMessage MirrorShrink)

    -- Expand tile
    , ((modm, xK_z), sendMessage MirrorExpand)

    -- multimedia keys
    , ((0, xF86XK_AudioLowerVolume ), spawn "pactl set-sink-volume 0 -5%")
    , ((0, xF86XK_AudioRaiseVolume ), spawn "pactl set-sink-volume 0 +5%")
    , ((0, xF86XK_AudioMute        ), spawn "pactl set-sink-mute 0 toggle")
    , ((0, xF86XK_AudioPlay        ), spawn "rhythmbox-client --play-pause")
    , ((0, xF86XK_AudioNext        ), spawn "rhythmbox-client --next")
    , ((0, xF86XK_AudioPrev        ), spawn "rhythmbox-client --previous")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 20")
    , ((0, xF86XK_MonBrightnessUp  ), spawn "xbacklight -inc 20")
    -- screenshot
    , ((0, xK_Print                ), spawn "sleep 0.2; scrot -s")
    , ((modm, xK_Print             ), spawn "scrot")
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N

    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask),  (copy, shiftMask .|. controlMask)]]
    ++


    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3

    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
-- myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
--  
--     -- mod-button1, Set the window to floating mode and move by dragging
--     [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
--  
--     -- mod-button2, Raise the window to the top of the stack
--     , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
--  
--     -- mod-button3, Set the window to floating mode and resize by dragging
--     , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
--  
--     -- you may also bind events to the mouse scroll wheel (button4 and button5)
--     ]
 
------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = minimize ( tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = spacing 4 $ gaps [(U,40), (L,40), (R,40), (D,40)] $ ResizableTall nmaster delta ratio []
 
     -- The default number of windows in the master pane
     nmaster = 1
 
     -- Default proportion of screen occupied by master pane
     ratio = 6/10
 
     -- Percent of screen to increment by when resizing panes
     delta = 3/100
 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
-- myManageHook = composeAll
--     [ className =? "MPlayer"        --> doFloat
--     , className =? "Gimp"           --> doFloat
--     , resource  =? "desktop_window" --> doIgnore
--     , resource  =? "kdesktop"       --> doIgnore 
--     , isFullscreen --> doFullFloat 
--     , className =? "Steam" --> doFullFloat
--     , className =? "steam" --> doFullFloat
--     ]
 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
--Bar
myXmonadBar = "dzen2 -x '0' -y '0' -h '24' -w '1100' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
myStatusBar = "conky -c /home/vinz/.xmonad/.conky_dzen | dzen2 -x '1100' -w '920' -h '24' -ta 'r' -bg '#1B1D1E' -fg '#FFFFFF' -y '0'"
myBitmapsDir = "/home/vinz/.xmonad/dzen2"

myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ defaultPP
    {
        ppCurrent           =   dzenColor "#ebac54" "#1B1D1E" . pad
      , ppVisible           =   dzenColor "white" "#1B1D1E" . pad
      , ppHidden            =   dzenColor "white" "#1B1D1E" . pad
      , ppHiddenNoWindows   =   dzenColor "#7b7b7b" "#1B1D1E" . pad
      , ppUrgent            =   dzenColor "#ff0000" "#1B1D1E" . pad
      , ppWsSep             =   " "
      , ppSep               =   "  |  "
      , ppLayout            =   dzenColor "#ebac54" "#1B1D1E" .
                                (\x -> case x of
                                    "Minimize Spacing 4 ResizableTall" -> "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                                    "Minimize Mirror Spacing 4 ResizableTall" -> "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                                    "Minimize Full" -> "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                                    "Simple Float" -> "~"
                                    _ -> x
                                )
      , ppTitle             =   (" " ++) . dzenColor "white" "#1B1D1E" . dzenEscape
      , ppOutput            =   hPutStrLn h
    }


------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    setWMName "LG3D"
    -- spawn "nautilus"
    -- spawn "sleep 10 && nm-applet"
    spawn "synclient HorizTwoFingerScroll=1"
    spawn "compton -bC --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc"
    spawn "sleep 3 && xflux -l 59.3293 -g 18.0686"
    spawn "sleep 5 && dropbox start"
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--

myPP = xmobarPP { 
  ppCurrent = xmobarColor "#888888" "",
  ppTitle = (\str -> ""), 
  ppLayout = (\str -> ""),
  ppHidden = (xmobarColor "#626262" ""),
  ppHiddenNoWindows = (\str -> "")
}

main = do
    dzenLeftBar <- spawnPipe myXmonadBar
    dzenRightBar <- spawnPipe myStatusBar
    xmonad $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
         -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        -- mouseBindings      = myMouseBindings,
        handleEventHook    = fullscreenEventHook,
        layoutHook         = myLayout,
        -- manageHook         = myManageHook,
        logHook            = myLogHook dzenLeftBar >> fadeInactiveLogHook 0xdddddddd,
        startupHook        = myStartupHook
    }
