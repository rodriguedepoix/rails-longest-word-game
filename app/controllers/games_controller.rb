require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    @letters
  end

  def score
    @random = params[:letters]
    @word = params[:word]

    @input_array = @word.split(//)
    @input_array.each do |x|
      if @random.split.include?(x) == false
        @result = "Your word do not use the letters #{@random}"
      else
        url = "https://wagon-dictionary.herokuapp.com/#{@word}"
        url_lecteur = open(url).read
        hash = JSON.parse(url_lecteur)

        if @api_result = hash['found']
          @result = "Congratulation, <<#{@word}>> is an english word.
          Your score is #{hash['length'].to_i} "
        else
          @result = "Sorry, <<#{@word}>> is not an english word."
        end
      end
    end
  end
end
