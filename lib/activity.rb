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

  def split
    total_cost / participants.count
  end

  def owed
    participants.each_with_object({}) do |participant, hash|
      name = participant[0]
      amt_paid = participant[1]

      hash[name] = split - amt_paid
    end
  end
end
