class Reunion
  attr_reader :name, :activities

  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(activity)
    activities << activity
  end

  def breakout
    activities.each_with_object(Hash.new(0)) do |activity, hash|
      activity.owed.each { |name, amt_owed| hash[name] += amt_owed }
    end
  end

  def summary
    breakout.to_a.map { |arr| "#{arr[0]}: #{arr[1]}" }.join("\n")
  end
end
