defmodule OneHackWeb.Router do
  use OneHackWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:assign_current_user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  pipeline :authenticated do
    plug(OneHack.Authenticate, repo: OneHack.Repo)
  end

  scope "/", OneHackWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/", OneHackWeb do
    pipe_through([:browser, :authenticated])
  end

  scope "/", OneHackWeb do
    pipe_through([:browser, :authenticated])

    resources(
      "/onehack",
      QuestionsController,
      only: [:index, :create, :new, :show]
    )
  end

  scope "/", OneHackWeb do
    pipe_through([:browser])

    resources(
      "/user",
      UsersController,
      only: [:create, :new]
    )
  end

  scope "/api", OneHackWeb, as: :api_login do
    pipe_through([:api])
    post("/login/validate", LoginApiController, :validate)
  end

  scope "/api", OneHackWeb, as: :api_answers do
    pipe_through([:api])
    post("/answers/post", AnswersApiController, :post)
    put("/answers/correct", AnswersApiController, :correct)
  end

  scope "/api", OneHackWeb, as: :api_questions do
    pipe_through([:api])
    post("/questions/close", QuestionsApiController, :close)
  end

  # Other scopes may use custom stacks.
  # scope "/api", OneHackWeb do
  #   pipe_through :api
  # end

  # Fetch the current user from the session and add it to `conn.assigns`. This
  # will allow you to have access to the current user in your views with
  # `@current_user`.
  def assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
