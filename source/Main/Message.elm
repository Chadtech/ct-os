module Main.Message exposing (Message(..), Handler)

import TextWriter.Message as TextWriter
import Main.Types.Software exposing (Software(..))


type Message
    = TextWriterMessage Int TextWriter.Message
    | New Software


type alias Handler a =
    a -> Message
