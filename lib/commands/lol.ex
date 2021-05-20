defmodule Chika.Commands.LOL do
  use Alchemy.Cogs
  alias Chika.Utils.Args, as: Args
  require Alchemy.Embed, as: Embed

  Cogs.def summoner do
    args = Args.parse(message.content)
    region = Enum.at(args, 0)

    username =
      Enum.slice(args, 1..2)
      |> Enum.join(" ")

    case HTTPoison.get(
           "https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{username}?api_key=#{
             Application.fetch_env!(:chika, :riot_key)
           }"
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        summoner = Poison.Parser.parse!(body, %{keys: :atoms})
        revisionDate = DateTime.from_unix!(summoner.revisionDate, :millisecond)

        %Embed{
          color: 0x36393E,
          description:
            "Name: **#{summoner.name}**(#{summoner.id})\nLevel: **#{summoner.summonerLevel}**\nRevision Date: **#{
              revisionDate
            }**",
          thumbnail: %{
            url:
              "http://ddragon.leagueoflegends.com/cdn/6.24.1/img/profileicon/#{
                summoner.profileIconId
              }.png"
          }
        }
        |> Embed.send()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Cogs.say("Unknown user")
    end
  end
end
