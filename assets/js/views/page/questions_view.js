import MainView from "../main";
var $ = require("jquery");
require("datatables.net");
import * as tableHelpers from "./table_helpers.js";

export default class View extends MainView {
  mount() {
    super.mount();

    tableHelpers.add_search_to_table("#questions_table");
    var table = tableHelpers.setup_table_with_data(
      "#questions_table",
      15,
      questions,
      questions_columns
    );
    tableHelpers.setup_search_for_table("#questions_table");
    console.log("QuestionsIndexView mounted");
  }

  unmount() {
    super.unmount();
    console.log("QuestionsIndexView unmounted");
  }
}
