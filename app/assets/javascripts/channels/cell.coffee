App.cell = App.cable.subscriptions.create "CellChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    canvas = document.getElementById('canvas')
    ctx = canvas.getContext('2d')
    ctx.fillStyle = 'green'
    position = data.message.position
    ctx.fillRect(position.x, position.y, data.message['mass'], data.message['mass'])

  move: (message) ->
    @perform 'move', message: message
