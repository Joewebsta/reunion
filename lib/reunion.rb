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
    breakout.to_a.map { |name_owed_arr| "#{name_owed_arr[0]}: #{name_owed_arr[1]}" }.join("\n")
  end

  def detailed_breakdown
    names = activities.map { |activity| activity.participants.keys }.flatten.uniq

    names.each_with_object({}) do |name, hash|
      hash[name] = activity_breakdown(name)
    end
  end

  def activity_breakdown(participant_name)
    activities.each_with_object([]) do |activity, array|
      next unless activity.participants.keys.include?(participant_name)

      activity_hash = {
        activity: activity.name,
        payees: determine_payees(activity, participant_name),
        amount: calc_amt(activity, participant_name)
      }

      array << activity_hash
    end
  end

  def determine_payees(activity, name)
    if activity.owed[name].negative?
      activity.owed.select { |_name, amt| amt.positive? }.keys
    else
      activity.owed.select { |_name, amt| amt.negative? }.keys
    end
  end

  def calc_amt(activity, name)
    payees_count = determine_payees(activity, name).count
    activity.owed[name] / payees_count
  end
end
