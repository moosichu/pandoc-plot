{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-|
Module      : $header$
Copyright   : (c) Laurent P René de Cotret, 2020
License     : GNU GPL, version 2 or above
Maintainer  : laurent.decotret@outlook.com
Stability   : internal
Portability : portable

Rendering Matplotlib code blocks.

Note that the MatplotlibM renderer supports two extra arguments:
    * @tight_bbox=True|False@ : Make plot bounding box tight. Default is False
    * @transparent=True|False@ : Make plot background transparent (perfect for web pages). Default is False.
-}

module Text.Pandoc.Filter.Plot.Renderers.Matplotlib (
      matplotlibSupportedSaveFormats
    , matplotlibCommand
    , matplotlibCapture
    , matplotlibExtraAttrs
    , matplotlibAvailable
) where

import           Text.Pandoc.Filter.Plot.Renderers.Prelude

import qualified Data.Map.Strict                           as M


matplotlibSupportedSaveFormats :: [SaveFormat]
matplotlibSupportedSaveFormats = [PNG, PDF, SVG, JPG, EPS, GIF, TIF]


matplotlibCommand :: Configuration -> FigureSpec -> FilePath -> Text
matplotlibCommand Configuration{..} _ fp = [st|#{matplotlibExe} "#{fp}"|]


matplotlibCapture :: FigureSpec -> FilePath -> Script
matplotlibCapture FigureSpec{..} fname = [st|
import matplotlib.pyplot as plt
plt.savefig(r"#{fname}", dpi=#{dpi}, transparent=#{transparent}, bbox_inches=#{tightBox})
|]
    where attrs        = M.fromList extraAttrs
          tight_       = readBool $ M.findWithDefault "False" "tight"  attrs
          transparent_ = readBool $ M.findWithDefault "False" "transparent" attrs
          tightBox     = if tight_ then ("'tight'"::Text) else ("None"::Text)
          transparent  = if transparent_ then ("True"::Text) else ("False"::Text)


matplotlibExtraAttrs :: M.Map Text Text -> (M.Map Text Text)
matplotlibExtraAttrs kv = M.filterWithKey (\k _ -> k `elem` ["tight_bbox", "transparent"]) kv


matplotlibAvailable :: Configuration -> IO Bool
matplotlibAvailable Configuration{..} = commandSuccess [st|#{matplotlibExe} -c "import matplotlib"|]


-- | Flexible boolean parsing
readBool :: Text -> Bool
readBool s | s `elem` ["True",  "true",  "'True'",  "'true'",  "1"] = True
           | s `elem` ["False", "false", "'False'", "'false'", "0"] = False
           | otherwise = error $ unpack $ mconcat ["Could not parse '", s, "' into a boolean. Please use 'True' or 'False'"]
