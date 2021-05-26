defmodule Chika.Utils.Lol do
  def profile_icon_url(profile_icon_id) when is_number(profile_icon_id) do
    "http://ddragon.leagueoflegends.com/cdn/6.24.1/img/profileicon/#{profile_icon_id}.png"
  end

  def find_summoner(region, username) when is_binary(region) and is_binary(username) do
    case Application.fetch_env(:chika, :riot_key) do
      :error -> {:error, :riot_key_not_provided}
      {:ok, api_key} ->
        api_key
        |> build_url(region, username)
        |> request()
    end
  end

  defp build_url(api_key, region, username) do
    "https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{username}?api_key=#{api_key}"
  end

  defp request(uri) do
    case HTTPoison.get(uri) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        summoner = parser_body(body)
        {:ok, summoner}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :unknown_user}
      rest ->
        IO.inspect(rest)
        {:error, :unknown_error}
    end
  end

  defp parser_body (body) do
    Poison.Parser.parse!(body, %{keys: :atoms})
  end
end
