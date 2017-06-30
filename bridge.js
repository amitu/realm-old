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

window._toElm = function(ctr, msg){
    var final = null;
    if (typeof ctr === "function") {
        if (ctr.length !== 1) {
            console.log("invalid ctr, has non 1-arity", ctr, ctr.length);
            return;
        }

        if (typeof msg !== "string") {
            // currently we are assuming only strings can be passed to
            // construct a full message. in future UI can also signal a
            // integer: eg slider, or a float value. signalling more
            // complex outputs should not be possible. Even integers etc
            // can be transported over the bridge by round-tripping to string
            console.log("invalid call, msg not string: ", typeof msg, msg);
            return;
        }

        final = ctr(msg);
    } else {
        if (typeof msg !== "undefined") {
            console.log("data passed to fully constructed message:", msg);
            return;
        }

        final = ctr;
    }

    console.log("sending", final);
    // noinspection JSUnresolvedVariable
    elm.ports.fromReact.send(final);
};
