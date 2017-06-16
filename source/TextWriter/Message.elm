module TextWriter.Message exposing (Message(..))

import Mouse exposing (Position)
import MouseEvents exposing (MouseEvent)


type Message
    = SetContent String
    | SetPosition Position
    | TitleMouseDown MouseEvent
    | TitleMouseUp
    | Close
