class CellStorage {
  constructor(list) {
    this.storage = new Set(list.map(opts => new Cell(opts)));
  }

  fetch(id) {
    // https://github.com/lodash/lodash/issues/858
    return _.find(Array.from(this.storage), { id: id });
  }

  forEach(fun) {
    return this.storage.forEach(fun);
  }

  push(elem) {
    this.storage.add(elem);
  }
}
