require 'pokebot/helpers/fetch_pokemon'

module Pokebot
  module Commands
    class Number < SlackRubyBot::Commands::Base
      match /^(?<bot>\w*) number ?(?<number>\w*)$/ do |client, data, match|
        number = match[:number]
        pokemon = []
        pokemon = FetchPokemon::number(number.to_i) if number
        pokemon = pokemon.select { |pok| pok['isDefault'] }.first
        # pokemon = pokemon.map do |pok|
        #   sprite = pok.dig('sprites', 'normal', 'male', 'front')
        #   "#{pok['identifier']}: #{sprite}"
        # end.join("\n")
        if pokemon
          client.web_client.chat_postMessage(
            channel: data.channel,
            text: "Pokemon number #{number} is #{pokemon['identifier']}",
            as_user: true,
            attachments: [
              {
                title: pokemon['identifier'],
                title_link: "https://bulbapedia.bulbagarden.net/wiki?search=#{pokemon['identifier']}",
                color: '#ee1515',
                thumb_url: pokemon.dig('sprites', 'normal', 'male', 'front'),
                # actions: [
                #   {
                #     name: "about",
                #     text: "About",
                #     type: "button"
                #   }
                #] # how to callback - how to call another command
              }
            ].to_json
          )
          # client.say(text: "Pokemon number #{number} is #{pokemon}", channel: data.channel)
        else
          client.say(text: "Sorry, I don't understand", channel: data.channel)
        end
      end
    end
  end
end
