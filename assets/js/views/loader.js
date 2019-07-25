import MainView from "./main";
import PageIndexView from "./page/page_index_view";
import QuestionsIndexView from "./page/questions_view";
import QuestionsShowView from "./page/questions_show_view";
import QuestionsNewView from "./page/questions_new_view";
import UsersNewView from "./page/users_new_view";

const views = {
  PageIndexView,
  QuestionsIndexView,
  QuestionsShowView,
  QuestionsNewView,
  UsersNewView
};

export default function loadView(viewName) {
  console.log(viewName);
  return views[viewName] || MainView;
}
