export default class MainView {
  mount() {
    console.log("MainView mounted");
  }

  unmount() {
    console.log("MainView unmounted");
  }
}

global.bootstrap = require("bootstrap");
