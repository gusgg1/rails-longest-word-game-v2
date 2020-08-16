class Game
  VOWELS = %w(A E I O U Y)

  class << self
    def generate_grid(grid_size)
      # grid = []
      # alphabet = ("A".."Z").to_a
      # grid_size.times do
      #   grid << alphabet[rand(26)]
      # end
      # grid

      # @letters = Array.new(10) { ('A'..'Z').to_a.sample }
      @letters = Array.new(5) { VOWELS.sample }
      @letters += Array.new(grid_size) { (('A'..'Z').to_a - VOWELS).sample }
      @letters.shuffle!
    end

    def run_game(attempt, grid, time_taken)
      if attempt_valid?(attempt, grid)
        if english_word?(attempt)
          return well_done(attempt, time_taken)
        else
          return not_english_word(time_taken)
        end
      else
        return not_in_grid(time_taken)
      end
    end

    private

    def attempt_valid?(attempt, grid)
      attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
    end

    def english_word?(word)
      response = open("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      json['found']
    end

    def well_done(attempt, time)
      {
        score: attempt.size * (60 - time),
        message: 'well done',
        time: time
      }
    end

    def not_english_word(time)
      {
        score: 0,
        message: "not an english word",
        time: time
      }
    end

    def not_in_grid(time)
      {
        score: 0,
        message: "not in the grid",
        time: time
      }
    end
  end
end