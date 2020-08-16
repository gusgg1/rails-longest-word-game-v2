require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Game.generate_grid(5)
    @start_time = Time.now
    session[:letters] = @letters
    session[:start_time] = @start_time
  end

  # without using session we can get "letters" from the hidden input tag
  # def score
  #   @letters = params[:letters].split
  #   @word = params[:word || ""].upcase
  #   @included = included?(@word, @letters)
  #   @english_word = english_word?(@word)
  # end

  def score
    @word = params[:word || ""].upcase
    @grid = session[:letters]
    start_time = Time.parse(session[:start_time])
    end_time = Time.now
    time_taken = (end_time - start_time).to_f

    session[:scores] = @word.size * (60 - time_taken) # how to computed all scores ???

    @result = Game.run_game(@word, @grid, time_taken)
  end
end
