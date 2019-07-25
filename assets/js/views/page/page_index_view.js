import MainView from "../main";
var $ = require("jquery");

export default class View extends MainView {
  mount() {
    super.mount();
    $(document).ready(function() {
      $("#login-button").on("click", function() {
        $("#error").hide();
        $.ajax({
          url: `/api/login/validate`,
          type: "POST",
          data: {
            credentials: {
              username: $("#username").val(),
              password: $("#password").val()
            }
          },
          success: function(_data, _statusText, _xhr) {
            window.location.href = "/onehack";
          },
          error: function(_xhr, _textStatus, errorThrown) {
            $("#error").text(errorThrown);
            $("#error").show();
          }
        });
      });
    });
    console.log("PageIndexView mounted");
  }

  unmount() {
    super.unmount();
    console.log("PageIndexView unmounted");
  }
}
