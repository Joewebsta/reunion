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
    before do
      activity1 = Activity.new('Brunch')
      activity1.add_participant('Maria', 20)
      activity1.add_participant('Luther', 40)
      subject.add_activity(activity1)

      activity2 = Activity.new('Drink')
      activity2.add_participant('Maria', 60)
      activity2.add_participant('Luther', 60)
      activity2.add_participant('Louis', 0)
      subject.add_activity(activity2)
    end

    it 'creates a new hash displaying what participants owe' do
      hash = { 'Maria' => -10, 'Luther' => -30, 'Louis' => 40 }
      expect(subject.breakout).to eql(hash)
    end
  end
end
