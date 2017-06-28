def task_elm():
    """
    ${rapydscript} compile --import-path . --bare main.pyj --output ${TEMPDIR}/t.js
    ${babel} components.jsx > ${TEMPDIR}/c.js
    cat vendor/jquery-2.2.2.min.js vendor/react.min.js vendor/react.dom.js \
        ../martd/src/martd/client.js \
        ${TEMPDIR}/c.js ${TEMPDIR}/t.js > ../static/charm.js
    rm -rf ${TEMPDIR}
    """
    return {
        "actions": [
            "elm-make Main.elm --output elm-stuff/build-artifacts/elm.js",
            "./node_modules/.bin/babel "
            "   --plugins transform-react-jsx "
            "   --presets es2015"
            "   components.jsx > elm-stuff/build-artifacts/components.js",
            "cat"
            "   node_modules/react/dist/react.min.js"
            "   node_modules/react-dom/dist/react-dom.min.js"
            "   elm-stuff/build-artifacts/components.js"
            "   elm-stuff/build-artifacts/elm.js"
            "   bridge.js"
            " > elm-stuff/build-artifacts/final.js"
        ],
        "file_dep": [
            "dodo.py", "Main.elm", "components.jsx", "bridge.js",
            "Native/Helpers.js",
            "node_modules/react/dist/react.min.js",
            "node_modules/react-dom/dist/react-dom.min.js",
        ],
        "targets": ["elm-stuff/build-artifacts/final.js"]
    }
