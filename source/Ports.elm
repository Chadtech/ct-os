port module Ports exposing (..)


port toJS : String -> Cmd message


port fromJS : (String -> message) -> Sub message
