module Helpers exposing (toMsg, toVal0, toVal1)

import Json.Encode as JE
import Native.Helpers


toVal0 : msg -> JE.Value
toVal0 =
    Native.Helpers.identity


toVal1 : (String -> msg) -> JE.Value
toVal1 =
    Native.Helpers.identity


toMsg : JE.Value -> msg
toMsg =
    Native.Helpers.identity
