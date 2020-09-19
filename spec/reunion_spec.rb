require './lib/activity'
require './lib/reunion'

describe Reunion do
  subject { Reunion.new('1406 BE') }

  describe 'init' do
    it 'has a name' do
      expect(subject.name).to eql '1406 BE'
    end

    it 'has no activities' do
      expect(subject.activities).to eql([])
    end
  end

  describe '#add_activity' do
    it 'adds an activity to the Reunion activity array' do
      activity = Activity.new('Brunch')
      subject.add_activity(activity)

      expect(subject.activities).to eql([activity])
    end
  end

  describe '#breakout' do
    it 'creates a new hash displaying what participants owe' do
      activity1 = Activity.new('Brunch')
      activity1.add_participant('Maria', 20)
      activity1.add_participant('Luther', 40)
      subject.add_activity(activity1)

      activity2 = Activity.new('Drink')
      activity2.add_participant('Maria', 60)
      activity2.add_participant('Luther', 60)
      activity2.add_participant('Louis', 0)
      subject.add_activity(activity2)

      hash = { 'Maria' => -10, 'Luther' => -30, 'Louis' => 40 }

      expect(subject.breakout).to eql(hash)
    end
  end

  describe '#summary' do
    it 'returns a string summary' do
      activity1 = Activity.new('Brunch')
      activity1.add_participant('Maria', 20)
      activity1.add_participant('Luther', 40)
      subject.add_activity(activity1)

      activity2 = Activity.new('Drink')
      activity2.add_participant('Maria', 60)
      activity2.add_participant('Luther', 60)
      activity2.add_participant('Louis', 0)
      subject.add_activity(activity2)

      expect(subject.summary).to eql("Maria: -10\nLuther: -30\nLouis: 40")
    end
  end

  describe '#detailed_breakout' do
    it 'returns a hash of a detailed breakout' do
      activity1 = Activity.new('Brunch')
      activity1.add_participant('Maria', 20)
      activity1.add_participant('Luther', 40)

      activity2 = Activity.new('Drinks')
      activity2.add_participant('Maria', 60)
      activity2.add_participant('Luther', 60)
      activity2.add_participant('Louis', 0)

      activity3 = Activity.new('Bowling')
      activity3.add_participant('Maria', 0)
      activity3.add_participant('Luther', 0)
      activity3.add_participant('Louis', 30)

      activity4 = Activity.new('Jet Skiing')
      activity4.add_participant('Maria', 0)
      activity4.add_participant('Luther', 0)
      activity4.add_participant('Louis', 40)
      activity4.add_participant('Nemo', 40)

      subject.add_activity(activity1)
      subject.add_activity(activity2)
      subject.add_activity(activity3)
      subject.add_activity(activity4)

      hash = {
        'Maria' => [
          { activity: 'Brunch', payees: ['Luther'], amount: 10 },
          { activity: 'Drinks', payees: ['Louis'], amount: -20 },
          { activity: 'Bowling', payees: ['Louis'], amount: 10 },
          { activity: 'Jet Skiing', payees: %w[Louis Nemo], amount: 10 }
        ],
        'Luther' => [
          { activity: 'Brunch', payees: ['Maria'], amount: -10 },
          { activity: 'Drinks', payees: ['Louis'], amount: -20 },
          { activity: 'Bowling', payees: ['Louis'], amount: 10 },
          { activity: 'Jet Skiing', payees: %w[Louis Nemo], amount: 10 }
        ],
        'Louis' => [
          { activity: 'Drinks', payees: %w[Maria Luther], amount: 20 },
          { activity: 'Bowling', payees: %w[Maria Luther], amount: -10 },
          { activity: 'Jet Skiing', payees: %w[Maria Luther], amount: -10 }
        ],
        'Nemo' => [
          { activity: 'Jet Skiing', payees: %w[Maria Luther], amount: -10 }
        ]
      }

      expect(subject.detailed_breakdown).to eql(hash)
    end
  end
end
