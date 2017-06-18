module Main.View exposing (view)

import Html exposing (Html, div, p, a, input, text)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (onClick)
import Main.Model exposing (Model)
import Main.Types.Software as Software exposing (Software(..))
import Main.Message exposing (Message(..))
import TextWriter.View as TextWriter
import TextWriter.MenuBar
import Tungsten.View as Tungsten
import Tungsten.MenuBar
import Array
import Util exposing ((:=))


view : Model -> Html Message
view model =
    List.concat
        [ [ programsView model ]
        , [ menuBar model ]
        , softwareWindows model
        ]
        |> div [ class "main" ]


menuBar : Model -> Html Message
menuBar { software } =
    case Array.toList software of
        [] ->
            div
                [ class "start-bar" ]
                [ ctButton
                , saveButton
                ]

        head :: _ ->
            List.concat
                [ [ ctButton ]
                , getMenuBarBody head
                , [ saveButton ]
                ]
                |> div [ class "start-bar" ]


getMenuBarBody : Software -> List (Html Message)
getMenuBarBody software =
    case software of
        TextWriter _ ->
            List.map
                (Html.map (TextWriterMessage 0))
                TextWriter.MenuBar.view

        Tungsten _ ->
            List.map
                (Html.map (TungstenMessage 0))
                Tungsten.MenuBar.view


ctButton : Html Message
ctButton =
    a
        [ onClick BringProgramsOut ]
        [ text "CT" ]


saveButton : Html Message
saveButton =
    a
        [ class "save"
        , onClick Save
        ]
        [ text "Save" ]


programsView : Model -> Html Message
programsView model =
    if not model.programsOut then
        Html.text ""
    else
        div
            [ class "programs-container" ]
            [ div
                [ class "field" ]
                [ p [] [ text "Programs" ]
                , input [] []
                ]
            , div
                [ class "programs-list" ]
                (List.indexedMap programItemView Software.all)
            ]


programItemView : Int -> Software -> Html Message
programItemView index software =
    let
        title_ =
            case software of
                TextWriter model ->
                    model.title

                Tungsten model ->
                    model.title
    in
        div
            [ classList
                [ "item" := True
                , "odd" := ((index % 2) == 1)
                ]
            , onClick (New software)
            ]
            [ p [] [ text title_ ] ]



-- SOFTWARE --


softwareWindows : Model -> List (Html Message)
softwareWindows =
    .software
        >> Array.indexedMap softwareWindow
        >> Array.toList
        >> List.reverse


softwareWindow : Int -> Software -> Html Message
softwareWindow index software =
    case software of
        TextWriter model ->
            Html.map
                (TextWriterMessage index)
                (TextWriter.view model)

        Tungsten model ->
            Html.map
                (TungstenMessage index)
                (Tungsten.view model)
