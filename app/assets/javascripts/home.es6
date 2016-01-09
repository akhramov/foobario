var Home = (function() {
  var _initialized = false;
  var _cellStorage;
  var _selfCell;

  var _init = function() {
    if (_initialized) {
      return;
    }

    domready(function() {
      paper.install(window);
      paper.setup(canvas);

      _cellStorage = gon.cells.map(opts => new Cell(opts));

      view.onMouseMove = function(event) {
        _selfCell.sendMove(event.point);
      };

      view.onFrame = function() {
        _cellStorage.forEach(element => element.drawMove());
      };

      _initialized = true;
    });
  }

  var _receive = function(data) {
    if (!_initialized) {
      return;
    }

    var elem = _.find(_cellStorage, elem => elem.id === data.id);

    if (!elem) {
      elem = new Cell(data);
      _cellStorage.push(elem);
    }

    if (elem.id === gon.my_id) {
      _selfCell = elem;
    }

    elem.receiveMove(data);
  }

  return {
    init: _init,
    receive: _receive
  }
})();
