require 'spec_helper'

describe Pokebot::Bot do
  def app
    Pokebot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'
end
