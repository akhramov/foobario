class Cell {
  constructor({ id: id, position: position, radius: radius }) {
    this.id = id;
    this.destination = new Point(position);
    this.path = Path.Circle({
      center: this.destination,
      radius: radius,
      fillColor: 'black'
    });

    this.move = function(position) { App.cell.move(position); }
    this.sendMove = _.throttle(this.move, 100);
  }

  receiveMove({ position: position }) {
    this.destination = new Point(position);
  }

  drawMove() {
    var vector = this.destination.subtract(this.path.position);
    this.path.position = this.path.position.add(vector.divide(30));
  }
}
