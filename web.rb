require 'sinatra/base'

module Pokebot
  class Web < Sinatra::Base
    get '/' do
      'do pokemans'
    end

    post '/info' do
      "#{params}"
    end
  end
end
