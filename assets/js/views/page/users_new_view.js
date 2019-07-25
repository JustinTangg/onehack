import MainView from "../main";
var $ = require("jquery");

export default class View extends MainView {
  mount() {
    super.mount();
    $(document).ready(function() {
      $("#back-button").on("click", function() {
        window.location.href = "/";
      });
    });
    console.log("UsersNewView mounted");
  }

  unmount() {
    super.unmount();
    console.log("UsersNewView unmounted");
  }
}
