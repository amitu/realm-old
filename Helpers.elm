module Helpers exposing (floatMsg, intMsg, msg, oMsg, strMsg, toMsg)

import Json.Decode as JD
import Json.Encode as JE
import Native.Helpers
import Result


msg : msg -> JE.Value
msg msg =
    JE.object
        [ ( "kind", JE.string "msg" )
        , ( "msg", Native.Helpers.identity msg )
        ]


strMsg : (String -> msg) -> JE.Value
strMsg msg =
    JE.object
        [ ( "kind", JE.string "string" )
        , ( "ctr", Native.Helpers.identity msg )
        ]


intMsg : (Int -> msg) -> JE.Value
intMsg msg =
    JE.object
        [ ( "kind", JE.string "int" )
        , ( "ctr", Native.Helpers.identity msg )
        ]


floatMsg : (Float -> msg) -> JE.Value
floatMsg msg =
    JE.object
        [ ( "kind", JE.string "float" )
        , ( "ctr", Native.Helpers.identity msg )
        ]


oMsg : JD.Decoder a -> (a -> msg) -> JE.Value
oMsg decoder msg =
    JE.object
        [ ( "kind", JE.string "decoder" )
        , ( "decoder", Native.Helpers.identity decoder )
        , ( "ctr", Native.Helpers.identity msg )
        ]


toMsg : JE.Value -> msg
toMsg =
    Native.Helpers.identity
