class Activity
  attr_reader :name, :participants
  attr_accessor :total_cost

  def initialize(name)
    @name = name
    @participants = {}
    @total_cost = 0
  end

  def add_participant(name, amt_paid)
    participants[name] = amt_paid
    self.total_cost += amt_paid
  end
end
