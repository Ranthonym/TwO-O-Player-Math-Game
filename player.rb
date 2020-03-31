class Player
  attr_accessor :score
  attr_reader :name

  def initialize(name)
    @score = 3
    @name = name
  end


  def score_tracker
    "#{@score}/3"
  end

end
