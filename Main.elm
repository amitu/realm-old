port module Main exposing (..)

import Json.Decode as JD
import Json.Encode as JE
import Native.Helpers


type alias Model =
    { value : String }


type Msg
    = OnClick
    | OnInput String
    | FromReact JE.Value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnClick ->
            ( model, Cmd.none )

        OnInput str ->
            ( { model | value = str }, Cmd.none )

        FromReact imsg ->
            update (Native.Helpers.fromNative <| Debug.log "imsg" imsg) model


serialize : Model -> JE.Value
serialize model =
    JE.object
        [ ( "value", JE.string model.value )
        , ( "onClick", Native.Helpers.toNative OnClick )
        , ( "onInput", Native.Helpers.toNative OnInput )
        ]


publish_it : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
publish_it ( model, cmd ) =
    -- convert model to JE.Value, and append it to Cmd
    ( model, Cmd.batch [ cmd, toReact <| serialize model ] )


subscriptions : Model -> Sub Msg
subscriptions model =
    fromReact FromReact


main : Program Never Model Msg
main =
    Platform.program
        { init = ( { value = "hello" }, Cmd.none ) |> publish_it
        , update = \msg model -> update msg model |> publish_it
        , subscriptions = subscriptions
        }


port toReact : JE.Value -> Cmd msg


port fromReact : (JE.Value -> msg) -> Sub msg
