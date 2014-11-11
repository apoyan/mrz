require 'spec_helper'

describe Mrz::CheckDigit do

  context '#calculate' do

    subject { Mrz::CheckDigit.new("AB2134<<<") }

    it 'should calculate check digit' do
      expect(subject.calculate).to eq(5)
    end

  end

end
