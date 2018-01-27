require 'pokebot/helpers/fetch_pokemon'

module Pokebot
  module Commands
    class About < SlackRubyBot::Commands::Base
      match /^(?<bot>\w*) about (?=\S*['-]?)(?<pokemon_name>[a-zA-Z'-]+)/ do |client, data, match|
        pokemon_name = match[:pokemon_name]

        pokemon = FetchPokemon::find_pokemon(pokemon_name) unless pokemon_name.empty?
        if pokemon
          pokemon_name = pokemon.dig('species', 'identifier').capitalize
          pokemon_data = {
            # "name" => pokemon.dig('species', 'identifier'),
            "height" => pokemon.dig('height'),
            "weight" => pokemon.dig('weight'),
            "type" => pokemon.dig('pokemonTypes').map { |types| types['type']['identifier'] }.join(', '),
            # "image" => pokemon.dig('sprites', 'normal', 'male', 'front'),
            "evolves from" => pokemon.dig('species', 'evolvesFromSpecies', 'identifier'),
            "evolves into" => pokemon.dig('species', 'evolvesIntoSpecies').map { |p| p['identifier']}.join(', ')
        }.select { |k, v| v.present? }
          
          pokemon_string = pokemon_data.map do |key, value|
            "#{key}: #{value}"
          end.join("\n")
          client.web_client.chat_postMessage(
            channel: data.channel,
            # text: pokemon_string,
            as_user: true,
            attachments: [
              {
                title: pokemon_name,
                title_link: "https://bulbapedia.bulbagarden.net/wiki?search=#{pokemon_name}",
                text: pokemon_string,
                color: '#ee1515',
                thumb_url: pokemon.dig('sprites', 'normal', 'male', 'front'),
                # text: pokemon_string,
              }
            ].to_json
          )
          # client.say(text: pokemon_string, channel: data.channel)
        else
          client.say(text: "Sorry, I don't understand", channel: data.channel)
        end
      end
    end
  end
end
