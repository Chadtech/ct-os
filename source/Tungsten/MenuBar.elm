module Tungsten.MenuBar exposing (..)

import Html exposing (Html, div, a, text)
import Html.Attributes exposing (class)
import Tungsten.Message exposing (Message(..))


view : List (Html Message)
view =
    [ a [] [ text "File" ] ]
