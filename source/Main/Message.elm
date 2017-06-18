module Main.Message exposing (Message(..), Handler)

import TextWriter.Message as TextWriter
import Tungsten.Message as Tungsten
import Main.Types.Software exposing (Software(..))


type Message
    = TextWriterMessage Int TextWriter.Message
    | TungstenMessage Int Tungsten.Message
    | New Software
    | BringProgramsOut
    | Save


type alias Handler a =
    a -> Message
