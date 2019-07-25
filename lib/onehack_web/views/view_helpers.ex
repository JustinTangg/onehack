defmodule OneHackWeb.ViewHelpers do
  def column_headers(columns) do
    columns
    |> Enum.reduce([], fn {_data, column}, acc -> ["<th>#{column}</th>" | acc] end)
    |> Enum.reverse()
    |> Enum.join("\n")
  end

  def build_columns_json(columns) do
    %{data: Enum.map(columns, &column_json/1)}
  end

  def column_json({column, _}) do
    %{data: column}
  end
end
