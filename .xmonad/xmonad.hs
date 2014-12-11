import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Actions.UpdatePointer
import           XMonad.Util.Run              (spawnPipe)
import           XMonad.Util.EZConfig
import qualified XMonad.StackSet              as W
import           System.IO

main = do
    xmobar <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { modMask     = mod4Mask
        , terminal    = "sakura"
        , borderWidth = 3
        , manageHook  = manageDocks <+> manageHook defaultConfig
        , layoutHook  = avoidStruts $ layoutHook defaultConfig
        , logHook     = do
            dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmobar
                , ppTitle  = xmobarColor "#859900" "" . shorten 100
                }
            updatePointer $ Relative 0.5 0.5
        } `additionalKeysP`
        (
            -- switch mod-<number> from greedyView to view so that if a
            -- workspace is currently displayed on another monitor, focus
            -- shifts instead of the workspaces swapping
            [ (extraModMasks ++ "M-" ++ ws, action ws)
              | ws <- take 9 $ map show [1..]
              , (extraModMasks, action) <- [ ("",   windows . W.view)
                                           , ("S-", windows . W.shift)
                                           ]
            ] ++
            [ ("M-p", spawn $ "dmenu_run -fn 'Source Code Pro:size=11' " ++
                              "-nb '#073642' -nf '#839496' -sb '#268bd2'")
            , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -- -2%")
            , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -- +2%")
            , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ -- toggle")
            , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
            , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
            ]
        )
