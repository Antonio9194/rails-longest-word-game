class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].downcase

    @message = "Sorry, your word is not in the grid!"
    return @message unless word_in_grid?(@word, @letters)

    require "open-uri"

    url = "https://dictionary.lewagon.com/#{@word}"
    response = URI.parse(url).read
    result = JSON.parse(response)

     if result["found"]
        @message = "✅ '#{@word}' is a valid English word and matches the grid!"
      else
        @message = "❌ '#{@word}' can be built from the grid, but is NOT a valid English word."
      end
  end

  private
    def word_in_grid?(word, grid)
    word.chars.all? do |letter|
      word.count(letter) <= grid.count(letter)
    end
  end
end
