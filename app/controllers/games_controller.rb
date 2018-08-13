require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @word = params[:answer]
    @letters = params[:letters]
    @score = 0

      if check_the_word(@word, @letters) == false
        @display_result = "Your word contains one or more letters not included in the available array of letters..."
      elsif check2(@word) == false
        @display_result = "Your word is not a valid English word"
      else
        @display_result = "Your word is valid!"
        @score = "Your score is: #{@word.length}"
      end
  end

  def check_the_word(word, letters)
    checkword = word.split(//)
    checkword.each do |letter|
      if letters.include?(letter) == false
        return false
      else
        return true
      end
    end
  end

  def check2(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json_file = open(url).read
    json_doc = JSON.parse(json_file)

    json_doc["found"]
  end
end
