require 'spec_helper'

describe Mrz::Encoder do

  context '#convert' do

    subject { Mrz::Encoder.new("test Æ") }

    it 'should convert weird charachters to agreed values' do
      expect(subject.convert).to eq("test AE")
    end

  end

end
