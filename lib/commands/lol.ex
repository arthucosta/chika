defmodule Chika.Commands.LOL do
  use Alchemy.Cogs
  alias Chika.Utils.{Args,Lol}
  alias Alchemy.Embed

  import Embed

   Cogs.def summoner do
     args = Args.parse(message.content)
     region = Enum.at(args, 0)

     username =
       Enum.slice(args, 1..2)
       |> Enum.join(" ")

    case Lol.find_summoner(region, username) do
      {:error, :riot_key_not_provided} ->
        Cogs.say("Command is not currently available, try later.")
      {:error, :unknown_user} ->
        Cogs.say("Unknown user")
      {:error, :unknown_error} ->
        Cogs.say("Unkown error, try later.")
      {:ok, summoner} ->
        IO.puts "chegou!!"
        IO.inspect(summoner)
        Embed.send(build_embed(summoner))
    end
  end

  defp build_embed (%{
    id: id,
    name: name,
    profileIconId: iconId,
    revisionDate: date,
    summonerLevel: level,
    }) do
    revisionDate = DateTime.from_unix!(date, :millisecond)

    %Embed{}
      |> color(0x36393E)
      |> thumbnail(Lol.profile_icon_url(iconId))
      |> description("Name: **#{name}** (#{id})\nLevel: **#{level}**\nRevision Date: **#{revisionDate}**")
  end
end
