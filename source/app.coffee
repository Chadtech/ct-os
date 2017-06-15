app = Elm.Main.fullscreen()

app.ports.toJS.subscribe (thing) ->
    console.log thing


fromJS = (thing) ->
    app.ports.fromJS.send thing