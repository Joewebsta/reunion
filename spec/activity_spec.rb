require './lib/activity'

describe Activity do
  subject { Activity.new('Brunch') }

  describe '#initialize' do
    it 'is an instance of Activity' do
      expect(subject).to be_an_instance_of Activity
    end

    it 'has a name' do
      expect(subject.name).to eql('Brunch')
    end

    it 'has no participants' do
      expect(subject.participants).to eql({})
    end
  end

  describe '#add_participant' do
    before { subject.add_participant('Maria', 20) }

    context 'when one participant is added' do
      it 'creates a new participants hash item' do
        expect(subject.participants).to eql({ 'Maria' => 20 })
      end

      it 'updates total_cost' do
        expect(subject.total_cost).to eql(20)
      end
    end

    context 'when a second participant is added' do
      before { subject.add_participant('Luther', 40) }

      it 'creates a new participants hash item' do
        expect(subject.participants).to eql({ 'Maria' => 20, 'Luther' => 40 })
      end

      it 'updates total_cost' do
        expect(subject.total_cost).to eql(60)
      end
    end
  end

  describe '#total_cost' do
    it 'returns the sum of participant costs' do
      subject.add_participant('Maria', 20)
      subject.add_participant('Luther', 40)

      expect(subject.total_cost).to eql(60)
    end
  end

  describe '#split' do
    it 'divides total_cost by the number of participants' do
      subject.add_participant('Maria', 20)
      subject.add_participant('Luther', 40)

      expect(subject.split).to eql(30)
    end
  end

  describe '#owed' do
    it 'creates a new hash that shows what each participant owes' do
      subject.add_participant('Maria', 20)
      subject.add_participant('Luther', 40)

      expect(subject.owed).to eql({ 'Maria' => 10, 'Luther' => -10 })
    end
  end
end
