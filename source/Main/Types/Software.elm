module Main.Types.Software exposing (..)

import TextWriter.Model as TextWriter
import Tungsten.Model as Tungsten


type Software
    = TextWriter TextWriter.Model
    | Tungsten Tungsten.Model


all : List Software
all =
    [ TextWriter (TextWriter.init "")
    , Tungsten (Tungsten.init "")
    ]
