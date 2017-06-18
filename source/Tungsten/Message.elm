module Tungsten.Message exposing (..)

import Mouse exposing (Position)
import MouseEvents exposing (MouseEvent)


type Message
    = SetPosition Position
    | TitleMouseDown MouseEvent
    | TitleMouseUp
    | SetUrlField String
    | GoToUrl
    | Close
