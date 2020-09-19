class Activity
  attr_reader :name, :participants

  def initialize(name)
    @name = name
    @participants = {}
  end

  def add_participant(name, amt_paid)
    participants[name] = amt_paid
  end

  def total_cost
    participants.values.sum
  end

  def split
    total_cost / participants.count
  end

  def owed
    participants.transform_values { |amt_paid| split - amt_paid }
  end
end
