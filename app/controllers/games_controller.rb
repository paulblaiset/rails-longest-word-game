require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split
    if included?(@word.upcase, @letters)
      if english_word?(@word)
        score = compute_score(@word)
        @score = [score, "well done"]
      else
        @score = [0, "not an english word"]
      end
    else
      @score = [0, "not in the grid"]
    end
  end


  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end


  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def compute_score(attempt)
    attempt.size * 3
  end


end




# def score
#     @
#     @word = params[:word]
#     @letters = params[:letters].split
#     if included?(@word.upcase, @letters)
#       if english_word?(@word)
#         score = compute_score(@word, time)
#         @score = [score, "well done"]
#       else
#         @score = [0, "not an english word"]
#       end
#     else
#       @score = [0, "not in the grid"]
#     end
#   end


#   def included?(guess, grid)
#     guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
#   end


#   def english_word?(word)
#     response = open("https://wagon-dictionary.herokuapp.com/#{word}")
#     json = JSON.parse(response.read)
#     return json['found']
#   end

#   def compute_score(attempt, time_taken)
#     time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
#   end


# end







