require 'rspec'

describe Mrz::Formatters::Name do
  context 'with the middlename' do
    subject { described_class.new('firstname', 'lastname', 'middlename').first_name }

    it { should == 'firstname middlename'}
  end

  context 'without the middlename' do
    subject { described_class.new('firstname', 'lastname').first_name }

    it { should == 'firstname'}
  end

end