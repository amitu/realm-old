port module Main exposing (..)

import Helpers exposing (toMsg, toVal0, toVal1)
import Json.Decode as JD
import Json.Encode as JE


type alias Model =
    { value : String }


type alias ReactModel =
    { value : String
    , onClick : Msg
    , onInput : String -> Msg
    }


reactModel : ReactModel -> JE.Value
reactModel r =
    JE.object
        [ ( "value", JE.string r.value )
        , ( "onClick", toVal0 r.onClick )
        , ( "onInput", toVal1 r.onInput )
        ]


type Msg
    = OnClick
    | OnInput String
    | FromReact JE.Value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnClick ->
            ( { model | value = "hello" }, Cmd.none )

        OnInput str ->
            ( { model | value = str }, Cmd.none )

        FromReact imsg ->
            update (toMsg imsg) model


serialize : Model -> JE.Value
serialize model =
    { value = model.value
    , onClick = OnClick
    , onInput = OnInput
    }
        |> reactModel


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
