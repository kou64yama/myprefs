-- -*- mode: haskell; mode: haskell-indentation; fill-column: 80;-*-

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import Graphics.X11.ExtraTypes.XF86
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map as M


-- Now run xmonad with all the defaults we set up.
--
-- Run xmonad with the settings you specify. No need to modify this.
main = xmonad =<< myDzen defaultConfig

       -- simple stuff
       { terminal = myTermianl
       , focusFollowsMouse = myFocusFollowsMouse
       , borderWidth = myBorderWidth
       , modMask = myModMask
       -- , numlockMask = myNumlockMask
       , workspaces = myWorkspaces
       , normalBorderColor = myNormalBorderColor
       , focusedBorderColor = myFocusedBorderColor

       -- key bindings
       , keys = myKeys
       -- , mouseBindings = myMouseBindings

       -- hooks, layouts
       , layoutHook = myLayout
       , manageHook = myManageHook
       , logHook = myLogHook
       , startupHook = myStartupHook }

    where

      -- The preferred terminal program, which is used in a binding below and by
      -- certain contrib modules.
      myTermianl = "/usr/bin/urxvt"

      -- Width of the window border in pixels.
      myBorderWidth = 1

      -- modMask lets you specify which modkey you want to use. The default is
      -- mod1Mask ("left alt"). You may also consider using mod3Mask ("right
      -- alt"), which does not conflict with emacs keybindings. the "windows
      -- key" is usually mod4Mask.
      myModMask = mod4Mask

      -- The mask for the numlock key. Numlock status is "masked" from the
      -- current modifire status, so the keybindings will work with numlock on
      -- or off. You may need to change this on some systems.
      --
      -- You can find the numlock modifier by running "xmodmap" and looking for
      -- a modifier with Num_Lock bound to it:
      --
      -- > $ xmodmap | grep Num
      -- > mod2        Num_Lock (0x4d)
      --
      -- Set numlockMask = 0 if you don't have a numlock key, or want to treat
      -- numlock status separately.
      -- myNumlockMask = mod2Mask

      -- The default number of workspaces (virtual screens) and their names. By
      -- default we use numeric strings, but any string may be used ad a
      -- workspae name. The number of workspaces is determined by the length of
      -- this list.
      --
      -- A tagging example:
      --
      -- > workspaces = [ "web", "irc", "code" ] ++ map show [ 4..9 ]
      -- myWorkspaces = [ "1.Terminal", "2.Emacs", "3.Web", "4.Movie" ]
      --                ++ map show [ 5..9 ]
      myWorkspaces = map show [ 1..9 ]

      -- Border Colors for unfocused and focused windows, respectively.
      myNormalBorderColor = "#222222"
      myFocusedBorderColor = "#3366cc"

      -- Key bindings. Add, modify or remove key bindings here.
      myKeys conf@(XConfig { XMonad.modMask = modMask })
          = M.fromList $

            -- launch a terminal
            [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

            -- launch dmenu
            , ((modMask, xK_p), spawn "exe=`dmenu_run` && eval \"exec $exe\"")

            -- launch gmrun
            , ((modMask .|. shiftMask, xK_p), spawn "gmrun")

            -- close focused window
            , ((modMask .|. shiftMask, xK_c), kill)

            -- Rotate through the available layout algorithms
            , ((modMask, xK_space), sendMessage NextLayout)

            -- Reset the layouts on the current workspace to default
            , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

            -- Resize viewed windows to the correct size
            , ((modMask, xK_n), refresh)

            -- Move focus to the next window
            , ((modMask, xK_Tab), windows W.focusDown)

            -- Move focus to the next window
            , ((modMask, xK_j), windows W.focusDown)

            -- Move focus to the previouse window
            , ((modMask, xK_k), windows W.focusUp)

            -- Move focus to the master window
            , ((modMask, xK_m), windows W.focusMaster)

            -- Swap the focused window and the master window
            , ((modMask, xK_Return), windows W.swapMaster)

            -- Swap the focused window with next window
            , ((modMask .|. shiftMask, xK_j), windows W.swapDown)

            -- Swap the focused window with previouse window
            , ((modMask .|. shiftMask, xK_k), windows W.swapUp)

            -- Shrink the master area
            , ((modMask, xK_h), sendMessage Shrink)

            -- Expand the master area
            , ((modMask, xK_l), sendMessage Expand)

            -- Push window back into tiling
            , ((modMask, xK_t), withFocused $ windows . W.sink)

            -- Increment the number of windows in the master area
            , ((modMask, xK_comma), sendMessage (IncMasterN 1))

            -- Deincrement the number of windows in the master area
            , ((modMask, xK_period), sendMessage (IncMasterN (-1)))

            -- Quit xmonad
            , ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess))

            -- Restart xmonad
            , ((modMask, xK_q), restart "xmonad" True)

            ]
            ++

            -- mod-[1..9], Switch to workspace N
            -- mod-shift-[1..9], Move client to workspace N
            [ ((m .|. modMask, k), windows $ f i)
                  | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask) ]
            ]
            ++

            -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
            -- mod-Shift-{w,e,r}, Mobe client to screen 1, 2, or 3
            [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
              | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask) ]
            ]
            ++

            [ ((modMask, xK_f), sendMessage $ ToggleLayout) ]

            ++
            [ ((modMask, xK_s), spawn "/usr/bin/gdmflexiserver")
            ]

            ++
            [ ((0, xF86XK_AudioLowerVolume), spawn "~/.xmonad/bin/voldown.sh")
            , ((0, xF86XK_AudioRaiseVolume), spawn "~/.xmonad/bin/volup.sh")
            , ((0, xF86XK_AudioMute),        spawn "~/.xmonad/bin/volmute.sh")
            ]
      -- Layouts:
      --
      -- You can specify and transform your layouts by modifying these
      -- values. If you change layout bindings be sure to use 'mod-shift-space'
      -- after restarting (with 'mod-q') to reset your layout state to the new
      -- defaults, as xmonad preserves your old layout settings by defaults.
      --
      -- The available layouts. Note that each layout is separated by |||, which
      -- denotes layout choice.
      myLayout = smartBorders (toggleLayouts Full (tail ||| mirror))
          where tail = Tall 1 0.1 0.7
                mirror = Mirror tail

      -- Whether focus follows the mouse pointer
      myFocusFollowsMouse :: Bool
      myFocusFollowsMouse = True

      -- Status bars and logging
      --
      -- Perform an arbitrary action on each internal state change or X event.
      -- See the 'DynamicLog' extension for examples.
      --
      -- To emulate dwm's status bar
      --
      -- > logHook = dynamicLogDzen
      myLogHook = fadeInactiveLogHook 0xdddddddd

      -- Window rules:
      --
      -- Excute arbitrary actions and WindowSet manipulations when managing a
      -- new window. You can use this to, for example, always float a particular
      -- program, or have a client always appear on a particular workspace.
      --
      -- To find the property name associated with a program, use
      -- > xprop | grep WM_CLASS
      -- and click on the client you're interested in.
      --
      -- To match on the WM_NAME, you can use 'title' in the same way that
      -- 'className' and 'resource' are used below.
      myManageHook = composeAll
                     [ className =? "MPlayer" --> doFloat
                     -- , className =? "Gimp" --> doFloat
                     , resource =? "desktop_window" --> doIgnore
                     , resource =? "kdesktop" --> doIgnore
                     -- , className =? "Ida" --> doFloat
                     -- , className =? "URxvt" --> doShift "1.Terminal"
                     -- , className =? "Emacs" --> doShift "2.Emacs"
                     -- , className =? "Opera" --> doShift "3.Web"
                     -- , className =? "MPlayer" --> doShift "4.Movie"
                     -- , className =? "Vlc" --> doShift "4.Movie"
                     ]

      -- Startup hook
      --
      -- Perform an arbitrary action each time xmonad starts or is restarted
      -- with mod-q. Used by, e.g., Xmonad.Layout.PerWorkspace to initialize
      -- per-workspace layout choices.
      --
      -- By defaults, do nothing.
      myStartupHook = do
        spawn "~/.xmonad/bin/startup.sh"

      -- dzen2 statusbar.
      myDzen conf = statusBar ("dzen2 " ++ flags) myDzenPP toggleStrutsKey conf
          where
            toggleStrutsKey XConfig { XMonad.modMask = modMask } = ( modMask, xK_b )
            flags = "-e 'onstart=lower' -ta l -fg '#999999' -bg '#222222'"
            myDzenPP = dzenPP { ppCurrent = dzenColor "" "" . pad
                              , ppVisible = dzenColor "" "" . pad
                              , ppHidden = dzenColor "#444444" "" . pad
                              , ppTitle = dzenColor "" "" . pad
                              , ppLayout = dzenColor "" "#333333" . pad }
