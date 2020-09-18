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
end
