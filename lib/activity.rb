class Activity
  attr_reader :name, :participants
  attr_accessor :total_cost

  def initialize(name)
    @name = name
    @participants = {}
    @total_cost = 0
  end
end
