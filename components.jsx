/**
 * Created by amitu on 17/04/16.
 */

(function(){
    function get_cookie(name, c, C, i){
        c = document.cookie.split('; ');
        var cookies = {};

        for(i=c.length-1; i>=0; i--){
           C = c[i].split('=');
           cookies[C[0]] = C[1];
        }

        return cookies[name];
    }

    window.get_cookie = get_cookie;
})();


function createClass(cls) {
    if (!cls.componentWillMount) {
        cls.componentWillMount = function() {
            if (this.props.state)
                this.setState(this.props.state);
        }
    } else {
        var will = cls.componentWillMount;
        cls.componentWillMount = function() {
            if (this.props.state)
                this.setState(this.props.state);
            will();
        }
    }

    if (!cls.componentDidMount) {
        cls.componentDidMount = function() {
            if (this.props.init)
                this.props.init(this);
        }
    } else {
        var did = cls.componentDidMount;
        cls.componentDidMount = function() {
            if (this.props.init)
                this.props.init(this);
            did.call(this);
        }
    }

    if (!cls.getInitialState) {
        cls.getInitialState = function() {
            return {};
        }
    }

    return React.createClass(cls);
}

ReactApp = createClass({
    onInput(evt){
        window.toElm(this.props.onInput, evt.target.value);
    },
    onClick(){
        window.toElm(this.props.onClick)
    },
    render() {
        return (
            <div onClick={this.onClick}>
                Hello Realm
                <input onInput={this.onInput} value={this.props.value} />
            </div>
        );
    }
});
