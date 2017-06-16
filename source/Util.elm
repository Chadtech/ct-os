module Util exposing (..)


(:=) : a -> b -> ( a, b )
(:=) =
    (,)


(>-) : a -> b -> ( b, a )
(>-) =
    flip (,)


packWith : a -> b -> ( b, a )
packWith =
    flip (,)


{-| infixl 0 means the (:=) operator has the same precedence as (<|) and (|>),
meaning you can use it at the end of a pipeline and have the precedence work out.
-}
infixl 0 :=


infixl 0 >-


px : Int -> String
px int =
    (toString int) ++ "px"
