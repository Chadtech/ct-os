module Main.Types.DropDown exposing (..)


type DropDown msg
    = Options String Bool (List (DropDown msg))
    | Option String String (Maybe msg)
    | Divider


map : (a -> b) -> DropDown a -> DropDown b
map toB d =
    case d of
        Option label cmdText maybeMsg ->
            case maybeMsg of
                Nothing ->
                    Option label cmdText Nothing

                Just aMsg ->
                    Option label cmdText (Just (toB aMsg))

        Options label isDropped list ->
            map toB (Options label isDropped list)

        Divider ->
            Divider
