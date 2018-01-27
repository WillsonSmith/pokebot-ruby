module FetchPokemon
  def self.number(number)
    base_url = 'http://pokeql.com/'
    uri = URI("#{base_url}v1/")
    query = <<~NUMBERQUERY
    {
      PokemonSpecies (filter:{id: #{number}}) {
        edges {
          node {
            pokemons {
              isDefault
              identifier
              sprites {
                normal {
                  male {
                    front
                  }
                }
              }
            }
          }
        }
      }
    }
    NUMBERQUERY

    res = Net::HTTP.post(uri, {query: query}.to_json, "Content-Type" => "application/json")
    pokemon = if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    end
    pokemon['data']['PokemonSpecies']['edges'].first['node']['pokemons']
  end

  def self.find_pokemon(pokemon_name)
    base_url = 'http://pokeql.com/'
    query = <<~NAMEQUERY
      {
        Pokemon (filter:{identifier:"#{pokemon_name}"}) {
          edges {
            node {
              species {
                identifier
                evolvesFromSpecies {
                  identifier
                }
                evolvesIntoSpecies {
                  identifier
                }
              }
              height
              weight
              pokemonTypes {
                type {
                  identifier
                }
              }
              sprites {
                normal {
                  male {
                    front
                  }
                }
              }
            }
          }
        }
      }
    NAMEQUERY

    uri = URI("#{base_url}v1/")
    res = Net::HTTP.post(uri, {query: query}.to_json, "Content-Type" => "application/json")
    pokemon = if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    end
    pokemon['data']['Pokemon']['edges'][0]['node']
  end
end
