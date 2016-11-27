# Player - name, ai
# -init_type
# -init_code
# -init_guess

class Player
  attr_reader :name, :type

  def initialize(name, type = 1)
    @name = name
    @type = type
  end
end
