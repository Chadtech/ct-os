module TextWriter.View exposing (view)

import Html exposing (Html, p, div, textarea, text, a)
import Html.Attributes exposing (class, style, value)
import Html.Events exposing (onInput, onClick, onMouseUp)
import TextWriter.Model exposing (Model)
import TextWriter.Message exposing (Message(..))
import Util exposing ((:=), px)
import MouseEvents


view : String -> Model -> Html Message
view name model =
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
                    [ text name ]
                , a
                    [ class "close"
                    , onClick Close
                    ]
                    [ text "x" ]
                ]
            , div
                [ class "card-body" ]
                [ textarea
                    [ style
                        [ "width" := px (width - 16)
                        , "height" := px (height - 40)
                        ]
                    , value model.content
                    , onInput SetContent
                    ]
                    []
                ]
            ]
