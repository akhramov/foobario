App.cell = App.cable.subscriptions.create('CellChannel', {
  connected() {
    Home.init();
  },
  disconnected() {},
  received(data) {
    Home.receive(data);
  },
  move({x: x, y: y}) {
    return this.perform('move', { x: x, y: y });
  }
});
