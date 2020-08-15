class Recipe
  def initialize(name, description, prep_time, difficulty, done = false)
    @name = name
    @description = description
    @prep_time = prep_time
    @difficulty = difficulty
    @done = done
  end

  def done?
    @done
  end

  def already_done!
    @done = true
  end

  attr_reader :name, :description, :prep_time, :difficulty
end
