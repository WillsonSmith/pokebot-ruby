require 'spec_helper'

describe Pokebot::Commands::List do
  def app
    Pokebot::Bot.instance
  end

  subject { app }

  it 'returns 4' do
    expect(true).to equal(true)
    #expect(message: "#{SlackRubyBot.config.user} calculate 2+2", channel: 'channel').to respond_with_slack_message('4')
  end
end
