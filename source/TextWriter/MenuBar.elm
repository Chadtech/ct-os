module TextWriter.MenuBar exposing (..)

import Html exposing (Html, div, a, text)
import Html.Attributes exposing (class)
import Main.Types.DropDown exposing (DropDown(..))
import TextWriter.Message exposing (Message(..))


view : List (Html Message)
view =
    List.map fromDropDown dropdowns


fromDropDown : DropDown Message -> Html Message
fromDropDown dropDown =
    case dropDown of
        Options labelText isDropped children ->
            if isDropped then
                List.map fromDropDownRec children
                    |> (::) (text labelText)
                    |> a [ class "drop-down" ]
            else
                a
                    [ class "drop-down" ]
                    [ text labelText ]

        _ ->
            Html.text ""


fromDropDownRec : DropDown Message -> Html Message
fromDropDownRec dropdown =
    div
        []
        []


dropdowns : List (DropDown Message)
dropdowns =
    [ file ]


file : DropDown Message
file =
    Options "File"
        False
        [ Option "New" "" (Just New)
        , Option "Open" "" (Just Open)
        , Option "Save" "" (Just Save)
        , Divider
        , Option "Close" "" (Just Close)
        ]
