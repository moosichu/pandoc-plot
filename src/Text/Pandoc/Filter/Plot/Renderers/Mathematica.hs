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

Rendering Mathematica plots code blocks
-}

module Text.Pandoc.Filter.Plot.Renderers.Mathematica (
      mathematicaSupportedSaveFormats
    , mathematicaCommand
    , mathematicaCapture
    , mathematicaAvailable
) where

import           Text.Pandoc.Filter.Plot.Renderers.Prelude

mathematicaSupportedSaveFormats :: [SaveFormat]
mathematicaSupportedSaveFormats = [PNG, PDF, SVG, JPG, EPS, GIF, TIF]


mathematicaCommand :: Configuration -> FigureSpec -> FilePath -> Text
mathematicaCommand Configuration{..} _ fp = [st|#{mathematicaExe} -script "#{fp}"|]


mathematicaAvailable :: Configuration -> IO Bool
mathematicaAvailable Configuration{..} = commandSuccess [st|#{mathematicaExe} -h|] -- TODO: test this


mathematicaCapture :: FigureSpec -> FilePath -> Script
mathematicaCapture FigureSpec{..} fname = [st|
Export["#{fname}", %, #{show saveFormat}]
|]
