{- |
Module      : xmonad.hs
Description : Xmonad configuration.
Copyright   : (c) 2014 Kevin Fisher
License     : See README.

Maintainer  : Kevin Fisher <fisher.kevin.g@gmail.com>
Stability   : experimental
Portability : POSIX

Defines the configuration options for the xmonad window manager. For
more information about xmonad, see <http://xmonad.org/>
-}

import System.IO

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders(smartBorders, noBorders)
import XMonad.Layout.PerWorkspace(onWorkspace, onWorkspaces)
import XMonad.Layout.ResizableTile
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Scratchpad

import qualified XMonad.StackSet as W

-------------------------------------------------------------------------------
-- Main
-------------------------------------------------------------------------------
main :: IO ()
main = do
    dzenproc <- spawnPipe dzenCmd
    xmonad $ defaultConfig
      { borderWidth        = 1
      , focusedBorderColor = "#FF0000"
      , layoutHook         = myLayoutHook
      , logHook            = myLogHook dzenproc
      , manageHook         = manageDocks <+> myManageHook
      , modMask            = mod4Mask
      , normalBorderColor  = "#424242"
      , terminal           = "urxvt"
      , workspaces         = myWorkspaces
      } `additionalKeys` myKeys

-------------------------------------------------------------------------------
-- Custom Key Mapping
-------------------------------------------------------------------------------
myKeys :: [((KeyMask, KeySym), X ())]
myKeys = [ ((mod4Mask, xK_o), spawn "chromium")
         , ((mod4Mask, xK_g), spawn "gvim")
         , ((mod4Mask, xK_a), sendMessage MirrorExpand)
         , ((mod4Mask, xK_z), sendMessage MirrorShrink)
         , ((mod4Mask, xK_backslash), scratchpad)
         ] where scratchpad = scratchpadSpawnActionTerminal "urxvt"

-------------------------------------------------------------------------------
-- Dzen
-------------------------------------------------------------------------------
myLogHook :: Handle -> X ()
myLogHook hook = dynamicLogWithPP $ defaultPP
  { ppOutput          = hPutStrLn hook
  , ppCurrent         = dzenColor "#00afd7" "#000000" . wrap "[" "]"
  , ppVisible         = dzenColor "#eeeeee" "#000000" . wrap "[" "]"
  , ppHidden          = dzenColor "#eeeeee" "#000000" . noScratchPad
  , ppHiddenNoWindows = dzenColor "#424242" "#000000"
  , ppUrgent          = dzenColor "#eeeeee" "#ff0000"
  , ppWsSep           = " "
  , ppSep             = dzenColor "#999999" "#000000" " | "
  , ppLayout          = dzenColor "#eeeeee" "#000000"
  , ppTitle           = (" " ++)
  } where noScratchPad ws = if ws == "NSP" then "" else ws

dzenCmd :: String
dzenCmd = "dzen2 -x '0' -y '1050' -h '30' -w '1920' -ta 'l' -fg '#eeeeee' -bg '#000000' -fn 'Droid Sans Mono:size=12:antialias=true'"

-------------------------------------------------------------------------------
-- Layout
-------------------------------------------------------------------------------
myLayoutHook = onWorkspaces ["2:web"] webLayout
             $ onWorkspaces ["4:music" , "5:video", "6:graphics"] fullLayout
             $ defaultLayout

defaultLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full
    where
        tiled   = ResizableTall nmaster delta ratio slaves
        nmaster = 1
        ratio   = 1/2
        delta   = 3/300
        slaves  = []

fullLayout = avoidStruts $ smartBorders Full

webLayout = avoidStruts $ Mirror tiled ||| smartBorders Full
    where
        tiled   = ResizableTall nmaster delta ratio slaves
        nmaster = 2
        ratio   = 1/2
        delta   = 3/300
        slaves  = []

------------------------------------------------------------------------
-- Scratch Pad
------------------------------------------------------------------------
manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.33
    w = 1
    t = 1 - h
    l = 1 - w

-------------------------------------------------------------------------------
-- Window Management
-------------------------------------------------------------------------------
myManageHook :: ManageHook
myManageHook = (composeAll . concat $
  [ [resource  =? r --> doIgnore             | r <- xIgnores      ]
  , [className =? c --> doShift "2:web"      | c <- xWebs         ]
  , [className =? c --> doShift "3:vim"      | c <- xVim          ]
  , [className =? c --> doShift "4:music"    | c <- xMusicPlayers ]
  , [className =? c --> doShift "5:video"    | c <- xVideoPlayers ]
  , [className =? c --> doShift "6:graphics" | c <- xGraphics     ]
  , [className =? c --> doCenterFloat        | c <- xFloats       ]
  , [name      =? n --> doCenterFloat        | n <- xNames        ]
  , [isFullscreen   --> myFullFloat                                ]
  ]) <+> manageScratchPad

  where

    role          = stringProperty "WM_WINDOW_ROLE"
    name          = stringProperty "WM_NAME"
    xFloats       = [ "Xmessage", "VirtualBox", "QtQmlViewer" ]
    xWebs         = [ "Firefox", "Google-chrome", "Chromium" ]
    xMusicPlayers = [ "banshee", "Spotify" ]
    xVideoPlayers = [ "vlc" ]
    xGraphics     = [ "Gimp", "Dia" ]
    xVim          = [ "Gvim" ]
    xIgnores      = [ "desktop"
                    , "desktop_window"
                    , "notify-osd"
                    , "stalonetray"
                    , "trayer"
                    ]
    xNames        = [ "bashrun" ]

myFullFloat :: ManageHook
myFullFloat = doF W.focusDown <+> doFullFloat

-------------------------------------------------------------------------------
-- Workspaces
-------------------------------------------------------------------------------
myWorkspaces :: [String]
myWorkspaces = [ "1:main"
               , "2:web"
               , "3:vim"
               , "4:music"
               , "5:video"
               , "6:graphics"
               , "7:system"
               , "8:utility"
               ]


