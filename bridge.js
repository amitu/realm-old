//noinspection JSUnresolvedVariable
var elm = Elm.Main.worker();

//noinspection JSUnresolvedVariable
elm.ports.toReact.subscribe(function(model){
    console.log("toReact", model);
    ReactDOM.render(React.createElement(ReactApp, model), document.body)
});

window.toElm = function(ctr, msg){
    window.setTimeout(window._toElm, 0, ctr, msg);
};

window._toElm = function(spec, msg){
    var final = null;
    switch (spec.kind) {
        case "msg":
            final = spec.msg;
            break;
        case "string":
            if (typeof msg !== "string") {
                console.log(
                    "invalid call, msg not string: ",
                    typeof msg, msg, spec
                );
                return;
            }
            final = spec.ctr(msg);
            break;
        case "int":
            if (typeof msg !== "number" || (data % 1) !== 0) {
                console.log(
                    "invalid call, msg not int: ",
                    typeof msg, msg, spec
                );
                return;
            }
            final = spec.ctr(msg);
            break;
        case "float":
            if (typeof msg !== "number") {
                console.log(
                    "invalid call, msg not float: ",
                    typeof msg, msg, spec
                );
                return;
            }
            final = spec.ctr(msg);
            break;
        case "decoder":
            var res = window._a2(
                window._decodeValue, spec.decoder, msg
            );
            if (res.ctor === 'Err') {
                console.log('invalid value `' + msg + '`:\n' + res._0);
                return
            }
            final = spec.ctr(res._0);
            break;
        default:
            console.log("unknown spec", spec, msg);
            return;
    }

    console.log("sending", final);
    // noinspection JSUnresolvedVariable
    elm.ports.fromReact.send(final);
};
