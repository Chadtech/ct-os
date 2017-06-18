module Tungsten.View exposing (view)

import Html exposing (Html, p, div, form, input, text, a, iframe)
import Html.Attributes exposing (class, style, src, value)
import Html.Events exposing (onInput, onClick, onSubmit, onMouseUp)
import Tungsten.Model exposing (Model)
import Tungsten.Message exposing (Message(..))
import Util exposing ((:=), px)
import MouseEvents


view : Model -> Html Message
view model =
    let
        { width, height } =
            model.size

        { x, y } =
            model.position
    in
        div
            [ class "card"
            , style
                [ "width" := px width
                , "height" := px height
                , "top" := px y
                , "left" := px x
                ]
            ]
            [ div
                [ class "title"
                , MouseEvents.onMouseDown TitleMouseDown
                , onMouseUp TitleMouseUp
                ]
                [ p
                    []
                    [ text model.title ]
                , a
                    [ class "close"
                    , onClick Close
                    ]
                    [ text "x" ]
                ]
            , div
                [ class "card-body" ]
                [ form
                    [ class "field tungsten"
                    , onSubmit GoToUrl
                    ]
                    [ p [] [ text "url" ]
                    , input
                        [ value model.urlField
                        , onInput SetUrlField
                        ]
                        []
                    ]
                , iframe
                    [ src model.url
                    , style
                        [ "width" := px (width - 22)
                        , "height" := px (height - 76)
                        ]
                    ]
                    []
                ]
            ]
