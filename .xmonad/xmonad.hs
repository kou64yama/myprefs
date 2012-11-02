import Data.Monoid
import System.Exit
import XMonad
import XMonad.Core
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import Graphics.X11.ExtraTypes.XF86

import qualified Data.Map as Map
import qualified XMonad.StackSet as StackSet

main = xmonad =<< dzenWithPP myDzenPP defaultConfig
  { borderWidth        = myBorderWidth
  , workspaces         = myWorkspaces
  , layoutHook         = myLayoutHook
  , terminal           = myTerminal
  , normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , modMask            = myModMask
  , keys               = myKeys
  , logHook            = myLogHook
  , startupHook        = myStartupHook
  , mouseBindings      = myMouseBindings
  , manageHook         = myManageHook
  , handleEventHook    = myHandleEventHook
  , focusFollowsMouse  = myFocusFollowsMouse
  }

dzenWithPP pp conf = statusBar ("dzen2 " ++ flags) pp toggleStrutsKey conf
  where toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
        toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b)
        flags = "-e 'onstart=lower' -ta l -fg '#999999' -bg '#2d2d2d'"

myDzenPP = dzenPP
  { ppCurrent         = dzenColor "#2d2d2d" "#999999" . pad
  , ppVisible         = dzenColor "" "" . pad
  , ppHidden          = dzenColor "" "" . pad
  , ppHiddenNoWindows = const ""
  , ppUrgent          = dzenColor "" "" . pad
  , ppWsSep           = ""
  , ppSep             = ""
  , ppLayout          = dzenColor "#2d2d2d" "#666666" .
                        (\ x -> pad $ case x of
                            "Tall"        -> "^i(.xmonad/icons/tall.xbm)"
                            "Mirror Tall" -> "^i(.xmonad/icons/mtall.xbm)"
                            "Full"        -> "^i(.xmonad/icons/full.xbm)"
                            _             -> x
                        )
  , ppTitle           = (" " ++) . dzenEscape
  }

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1.TERM", "2.WEB"] ++ map show [3 .. 9 :: Int]

myModMask :: KeyMask
myModMask = mod4Mask

myBorderWidth :: Dimension
myBorderWidth = 1

myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor = "#2d2d2d"
myFocusedBorderColor = "#3366cc"

myManageHook :: ManageHook
myManageHook = composeAll
               [ className =? "MPlayer" --> doFloat
               , className =? "Gimp"    --> doFloat
               , className =? "URxvt"   --> doShift (myWorkspaces !! 0)
               , resource  =? "opera"   --> doShift (myWorkspaces !! 1)
               ]

myLogHook :: X ()
myLogHook = fadeInactiveLogHook 0xdddddddd

myHandleEventHook :: Event -> X All
myHandleEventHook _ = return (All True)

myStartupHook :: X ()
myStartupHook = spawn "~/.xmonad/bin/startup.sh"

myLayoutHook = smartBorders $ toggleLayouts Full (tall ||| mirror)
  where tall = Tall 1 0.1 0.6
        mirror = Mirror tall

myTerminal :: String
myTerminal = "urxvt"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myKeys :: XConfig Layout -> Map.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) =
  Map.fromList $
  [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
  , ((modMask,               xK_p     ), spawn "dmenu_run")
  , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun")
  , ((modMask .|. shiftMask, xK_c     ), kill)
  , ((modMask,               xK_space ), sendMessage NextLayout)
  , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
  , ((modMask,               xK_n     ), refresh)
  , ((modMask,               xK_Tab   ), windows StackSet.focusDown)
  , ((modMask .|. shiftMask, xK_Tab   ), windows StackSet.focusUp)
  , ((modMask,               xK_j     ), windows StackSet.focusDown)
  , ((modMask,               xK_k     ), windows StackSet.focusUp)
  , ((modMask,               xK_m     ), windows StackSet.focusMaster)
  , ((modMask,               xK_Return), windows StackSet.swapMaster)
  , ((modMask .|. shiftMask, xK_j     ), windows StackSet.swapDown)
  , ((modMask .|. shiftMask, xK_k     ), windows StackSet.swapUp)
  , ((modMask,               xK_h     ), sendMessage Shrink)
  , ((modMask,               xK_l     ), sendMessage Expand)
  , ((modMask,               xK_t     ), withFocused $ windows . StackSet.sink)
  , ((modMask,               xK_comma ), sendMessage (IncMasterN 1))
  , ((modMask,               xK_period), sendMessage (IncMasterN (-1)))
  , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
  , ((modMask,               xK_q     ), restart "xmonad" True)
  , ((modMask,               xK_f     ), sendMessage ToggleLayout)
  ]
  ++
  [ ((m .|. modMask, k), windows $ f i)
  | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
  , (f, m) <- [(StackSet.greedyView, 0), (StackSet.shift, shiftMask)]]
  ++
  [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
  | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
  , (f, m) <- [(StackSet.view, 0), (StackSet.shift, shiftMask)]]
  ++
  [ ((0, xF86XK_AudioLowerVolume), spawn "~/.xmonad/bin/volctrl.sh -d1")
  , ((0, xF86XK_AudioRaiseVolume), spawn "~/.xmonad/bin/volctrl.sh -i1")
  , ((0, xF86XK_AudioMute),        spawn "~/.xmonad/bin/volctrl.sh -m")
  ]

myMouseBindings :: XConfig Layout -> Map.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = modMask}) =
  Map.fromList
  [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w >> windows StackSet.shiftMaster)
  , ((modMask, button2), windows . (StackSet.shiftMaster .) . StackSet.focusWindow)
  , ((modMask, button3), \w -> focus w >> mouseResizeWindow w >> windows StackSet.shiftMaster)
  ]
