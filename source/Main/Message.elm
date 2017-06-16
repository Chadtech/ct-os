module Main.Message exposing (Message(..), Handler)

import TextWriter.Message as TextWriter


type Message
    = TextWriterMessage String TextWriter.Message


type alias Handler a =
    a -> Message
