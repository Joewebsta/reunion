require './lib/activity'

describe Activity do
  describe '#initialize' do
    subject { Activity.new('Brunch') }

    it 'is an instance of Activity' do
      expect(subject).to be_an_instance_of Activity
    end

    it 'has a name' do
      expect(subject.name).to eql('Brunch')
    end

    it 'has no participants' do
      expect(subject.participants).to eql({})
    end

    it 'has a cost total cost of zero' do
      expect(subject.total_cost).to eql(0)
    end
  end
end
