init = JSON.parse (localStorage.getItem "model")

app = Elm.Main.fullscreen(init)

app.ports.save.subscribe (model) ->
    localStorage.setItem "model", model