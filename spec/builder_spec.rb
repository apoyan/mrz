require 'spec_helper'

describe Mrz::Builder do

  context '#generate' do

    let(:params) {
      {
        country: 'UTO',
        first_name: 'Anna Maria',
        last_name: 'Eriksson',
        passport_number: 'L898902C',
        nationality: 'UTO',
        date_of_birth: Date.new(1969, 8, 6),
        gender: 'f',
        expiration_date: Date.new(1994, 6, 23),
        personal_number: 'ZE184226B'
      }
    }

    it 'should generate MRZ' do
      builder = Mrz::Builder.new(params)
      expect(builder.generate).to eq(
        [
          'P<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<',
          'L898902C<3UTO6908061F9406236ZE184226B<<<<<14'
        ]
      )
    end

    it 'should trim long names' do
      builder = Mrz::Builder.new(params.merge(last_name: 'ADSAKJSEFKJERIOFJERFIJEROFIJERIFJEROFIEJRFEIJRERFIJOEFI'))
      expect(builder.generate).to eq(
        [
          'P<UTOADSAKJSEFKJERIOFJERFIJEROFIJERIFJEROFIE',
          'L898902C<3UTO6908061F9406236ZE184226B<<<<<14'
        ]
      )
    end

    it 'should replace some utf8 chars to agreed values' do
      builder = Mrz::Builder.new(params.merge(last_name: 'TESTÆ'))
      expect(builder.generate).to eq(
        [
          'P<UTOTESTAE<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<<<',
          'L898902C<3UTO6908061F9406236ZE184226B<<<<<14'
        ]
      )
    end

    context 'when middle_name is present' do
      it 'should generate MRZ' do
        builder = Mrz::Builder.new(params.merge!(first_name: 'Anna', middle_name: 'Maria'))

        expect(builder.generate).to eq(
          [
            'P<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<',
            'L898902C<3UTO6908061F9406236ZE184226B<<<<<14'
          ]
        )
      end
    end

  end

end
