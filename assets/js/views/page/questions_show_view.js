import MainView from "../main";
var $ = require("jquery");

export default class View extends MainView {
  mount() {
    super.mount();
    $(document).ready(function() {
      var numbers = [question_phone_number.toString()];
      answers["data"].forEach(function(elem) {
        if (numbers.indexOf(elem["phone_number"]) === -1) {
          numbers.push(elem["phone_number"]);
        }
      });
      $("#back-button").on("click", function() {
        window.location.href = "/onehack";
      });

      $(".emoji").on("click", function(event) {
        if (!question_status || user_id !== question_user_id) {
          $.ajax({
            url: `/api/answers/correct`,
            type: "PUT",
            data: {
              attrs: {
                id: event.target.id,
                correct: true
              }
            },
            success: function(_data, _statusText, _xhr) {
              $.ajax({
                url: `/api/questions/close`,
                type: "POST",
                data: {
                  attrs: {
                    id: question_id,
                    closed: true
                  }
                },
                success: function(_data, _statusText, _xhr) {
                  $.ajax({
                    url: `fill_in_url_here`,
                    type: "POST",
                    success: function(_data, _statusText, _xhr) {
                      numbers.forEach(function(elem) {
                        send_sms(
                          elem,
                          `${question_name}'s question "${question}" has been answered`
                        );
                      });
                    },
                    error: function(_xhr, _textStatus, _errorThrown) {}
                  });
                }
              });
            }
          });
        }
      });

      $("#submit").on("click", function() {
        $.ajax({
          url: `/api/answers/post`,
          type: "POST",
          data: {
            attrs: {
              answer: $("#addanswer").val(),
              user_id: user_id,
              question_id: question_id
            }
          },
          success: function(_data, _statusText, _xhr) {}
        });
        var number_index = numbers.indexOf(user_phone_number);
        if (number_index != -1) {
          numbers.splice(number_index, 1);
        }
        numbers.forEach(function(elem) {
          send_sms(elem, $("#addanswer").val());
        });
      });
    });
    console.log("QuestionsShowView mounted");
  }

  unmount() {
    super.unmount();
    console.log("QuestionsShowView unmounted");
  }
}

function send_sms(number, comment) {
  $.ajax({
    url: `https://rest.nexmo.com/sms/json`,
    type: "POST",
    data: {
      api_key: "key",
      api_secret: "secret",
      to: number,
      from: "14063155992",
      text: comment
    },
    success: function(_data, _statusText, _xhr) {
      location.reload();
    },
    error: function(_xhr, _textStatus, _errorThrown) {
      location.reload();
    }
  });
}
