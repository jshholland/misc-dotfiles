import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Actions.UpdatePointer
import XMonad.Util.Run          (spawnPipe)
import System.IO

main = do
    xmobar <- spawnPipe "xmobar"
    xmonad defaultConfig
        { modMask     = mod4Mask
        , terminal    = "urxvt"
        , borderWidth = 3
        , manageHook  = manageDocks <+> manageHook defaultConfig
        , layoutHook  = avoidStruts $ layoutHook defaultConfig
        , logHook     = do
            dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmobar
                , ppTitle  = xmobarColor "green" "" . shorten 100
                }
            updatePointer $ Relative 0.5 0.5
        }
