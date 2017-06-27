var elm = Elm.Main.worker();

elm.ports.toReact.subscribe(function(model){
    console.log("toReact", model);
    ReactDOM.render(React.createElement(ReactApp, model), document.body)
});

window.toElm = function(msg) {
    console.log("toElm", msg);
    elm.ports.fromReact.send(msg);
};
