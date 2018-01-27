class Default < SlackRubyBot::Commands::Base
  command ''
  match(/^(?<bot>[[:alnum:][:punct:]@<>]*)$/u)

  def self.call(client, data, _match)
    help_info = <<~INSTRUCTIONOUTPUT
      commands:
      about <pokemon name>: give some details about a pokemon
      number <pokemon number>: tells you which pokemon is <pokemon number>
      list <number?>: list the first <number> pokemon, defaults to 100
    INSTRUCTIONOUTPUT
    client.say(channel: data.channel, text: help_info)
  end
end
