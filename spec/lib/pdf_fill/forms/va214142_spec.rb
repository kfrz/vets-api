# frozen_string_literal: true

require 'rails_helper'
require 'pdf_fill/hash_converter'

PDF_FORMS = PdfForms.new(Settings.binaries.pdftk)

def basic_class
  PdfFill::Forms::Va214142.new({})
end

describe PdfFill::Forms::Va214142 do
  let(:form_data) do
    {}
  end
  let(:new_form_class) do
    described_class.new(form_data)
  end
  def class_form_data
    new_form_class.instance_variable_get(:@form_data)
  end
  describe '#merge_fields' do
    it 'should merge the right fields', run_at: '2016-12-31 00:00:00 EDT' do
      expect(described_class.new(get_fixture('pdf_fill/21-4142/kitchen_sink')).merge_fields.to_json).to eq(
        get_fixture('pdf_fill/21-4142/merge_fields').to_json
      )
    end
  end

  describe '#expand_va_file_number' do
    context 'va file number is not blank' do
      let(:form_data) do
        {
          'vaFileNumber' => '12345678'
        }
      end
      it 'should expand the va file number correctly' do
        new_form_class.expand_va_file_number
        expect(
          JSON.parse(class_form_data.to_json)
        ).to eq(
          'vaFileNumber' => '12345678',
          'vaFileNumber1' => '12345678'
        )
      end
    end
    context 'va file number is blank' do
      let(:form_data) do
        {}
      end
      it 'should return without doing anything' do
        new_form_class.expand_va_file_number
        expect(
          JSON.parse(class_form_data.to_json)
        ).to eq({})
      end
    end
  end

  describe '#expand_ssn' do
    context 'ssn is not blank' do
      let(:form_data) do
        {
          'veteranSocialSecurityNumber' => '123456789'
        }
      end
      it 'should expand the ssn correctly' do
        new_form_class.expand_ssn
        expect(
          JSON.parse(class_form_data.to_json)
        ).to eq(
          'veteranSocialSecurityNumber' => { 'first' => '123', 'second' => '45', 'third' => '6789' },
          'veteranSocialSecurityNumber1' => { 'first' => '123', 'second' => '45', 'third' => '6789' },
          'veteranSocialSecurityNumber2' => { 'first' => '123', 'second' => '45', 'third' => '6789' },
          'veteranSocialSecurityNumber3' => { 'first' => '123', 'second' => '45', 'third' => '6789' }
        )
      end
    end
  end

  describe '#expand_claimant_address' do
    context 'veteran address is not blank' do
      let(:form_data) do
        {
          'veteranAddress' => {
            'city' => 'Baltimore',
            'country' => 'USA',
            'postalCode' => '21231-1234',
            'street' => 'street',
            'street2' => '1B',
            'state' => 'MD'
          }
        }
      end
      it 'should expand postal code and country correctly' do
        new_form_class.expand_claimant_address
        expect(
          JSON.parse(class_form_data.to_json)
        ).to eq(
          'veteranAddress' => {
            'city' => 'Baltimore',
            'country' => 'US',
            'postalCode' => {
              'firstFive' => '21231',
              'lastFour' => '1234'
            },
            'street' => 'street',
            'street2' => '1B',
            'state' => 'MD'
          }
        )
      end
    end
  end

  describe '#expand_veteran_full_name' do
    context 'contains middle initial' do
      let :form_data do
        {
          'veteranFullName' => {
            'first' => 'Testy',
            'middle' => 'Tester',
            'last' => 'Testerson'
          }
        }
      end
      it 'should expand veteran full name correctly' do
        new_form_class.expand_veteran_full_name
        expect(
          JSON.parse(class_form_data.to_json)
        ).to eq(
          'veteranFullName' => {
            'first' => 'Testy',
            'middle' => 'Tester',
            'last' => 'Testerson',
            'middleInitial' => 'T'
          },
          'veteranFullName1' => {
            'first' => 'Testy',
            'middle' => 'Tester',
            'last' => 'Testerson',
            'middleInitial' => 'T'
          }
        )
      end
    end
  end

  describe '#expand_veteran_dob' do
    context 'dob is not blank' do
      let :form_data do
        {
          'veteranDateOfBirth' => '1981-11-05'
        }
      end
      it 'should expand the birth date correctly' do
        new_form_class.expand_veteran_dob
        expect(
          JSON.parse(class_form_data.to_json)
        ).to eq(
          'veteranDateOfBirth' => {
            'year' => '1981',
            'month' => '11',
            'day' => '05'
          },
          'veteranDateOfBirth1' => {
            'year' => '1981',
            'month' => '11',
            'day' => '05'
          }
        )
      end
    end
  end

  describe '#expand_veteran_service_number' do
    context 'veteran service number is not blank' do
      let :form_data do
        {
          'veteranServiceNumber' => '987654321'
        }
      end
      it 'should expand veteran service number correctly' do
        new_form_class.expand_veteran_service_number
        expect(
          JSON.parse(class_form_data.to_json)
        ).to eq(
          'veteranServiceNumber' => '987654321',
          'veteranServiceNumber1' => '987654321'
        )
      end
    end
  end

  describe '#expand_limited_consent' do
    context 'limited consent is true' do
      let :form_data do
        {
          'limitedConsent' => 'true'
        }
      end
      it 'should convert limited consent value to yes' do
        new_form_class.expand_limited_consent
        expect(
          JSON.parse(class_form_data.to_json)
        ).to eq(
          'limitedConsent' => 'yes'
        )
      end
    end
    context 'limited consent is blank' do
      let :form_data do
        {}
      end
      it 'should convert limited consent value to no' do
        new_form_class.expand_limited_consent
        expect(
          JSON.parse(class_form_data.to_json)
        ).to eq(
          'limitedConsent' => 'no'
        )
      end
    end
  end

  describe '#combine_extra_date_ranges' do
    it 'should combine multiple date ranges correctly' do
      date_ranges = [
        {
          'from' => '1980-1-1',
          'to' => '1985-1-1'
        },
        {
          'from' => '1986-1-1',
          'to' => '1987-1-1'
        }
      ]
      expect(new_form_class.combine_extra_date_ranges(date_ranges)).to eq(
        "from: 1980-1-1 to: 1985-1-1\nfrom: 1986-1-1 to: 1987-1-1"
      )
    end
    it 'should show a single date range correctly' do
      date_ranges = [
        {
          'from' => '1980-1-1',
          'to' => '1985-1-1'
        }
      ]
      expect(new_form_class.combine_extra_date_ranges(date_ranges)).to eq(
        'from: 1980-1-1 to: 1985-1-1'
      )
    end
    it 'should handle no date ranges' do
      date_ranges = []
      expect(new_form_class.combine_extra_date_ranges(date_ranges)).to eq('')
    end
  end

  describe '#expand_provider_date_range' do
    it 'should expand the provider date range correctly' do
      providers = [
        {
          'providerFacilityName' => 'provider 1',
          'treatmentDateRange' => [
            {
              'from' => '1980-1-1',
              'to' => '1985-1-1'
            },
            {
              'from' => '1986-1-1',
              'to' => '1987-1-1'
            }
          ]
        },
        {
          'providerFacilityName' => 'provider 2',
          'treatmentDateRange' => [
            {
              'from' => '1980-2-1',
              'to' => '1985-2-1'
            },
            {
              'from' => '1986-2-1',
              'to' => '1987-2-1'
            }
          ]
        }
      ]
      expect(
        new_form_class.expand_provider_date_range(providers)
      ).to eq(
        [
          {
            'providerFacilityName' => 'provider 1',
            'dateRangeStart0' => '1980-1-1',
            'dateRangeEnd0' => '1985-1-1',
            'dateRangeStart1' => '1986-1-1',
            'dateRangeEnd1' => '1987-1-1'
          },
          {
            'providerFacilityName' => 'provider 2',
            'dateRangeStart0' => '1980-2-1',
            'dateRangeEnd0' => '1985-2-1',
            'dateRangeStart1' => '1986-2-1',
            'dateRangeEnd1' => '1987-2-1'
          }
        ]
      )
    end
  end

  describe '#expand_provider_address' do
    it 'should expand the provider address correctly' do
      providers = [
        {
          'providerFacilityName' => 'provider 1',
          'providerFacilityAddress' => {
            'street' => '123 Main Street',
            'street2' => '1B',
            'city' => 'Baltimore',
            'state' => 'MD',
            'country' => 'USA',
            'postalCode' => '21200-1111'
          }
        },
        {
          'providerFacilityName' => 'provider 2',
          'providerFacilityAddress' => {
            'street' => '456 Main Street',
            'street2' => '1B',
            'city' => 'Baltimore',
            'state' => 'MD',
            'country' => 'USA',
            'postalCode' => '21200-1111'
          }
        }
      ]
      expect(
        new_form_class.expand_provider_address(providers)
      ).to eq(
        [
          {
            'providerFacilityName' => 'provider 1',
            'street' => '123 Main Street',
            'street2' => '1B',
            'city' => 'Baltimore',
            'state' => 'MD',
            'country' => 'US',
            'postalCode' => {
              'firstFive' => '21200',
              'lastFour' => '1111'
            }
          },
          {
            'providerFacilityName' => 'provider 2',
            'street' => '456 Main Street',
            'street2' => '1B',
            'city' => 'Baltimore',
            'state' => 'MD',
            'country' => 'US',
            'postalCode' => {
              'firstFive' => '21200',
              'lastFour' => '1111'
            }
          }
        ]
      )
    end
  end

  describe '#expand_provider_extras' do
    it 'should expand the provider address and treatment datescorrectly' do
      providers = [
        {
          'providerFacilityName' => 'provider 1',
          'providerFacilityAddress' => {
            'street' => '123 Main Street',
            'street2' => '1B',
            'city' => 'Baltimore',
            'state' => 'MD',
            'country' => 'USA',
            'postalCode' => '21200-1111'
          },
          'treatmentDateRange' => [
            {
              'from' => '1980-1-1',
              'to' => '1985-1-1'
            },
            {
              'from' => '1986-1-1',
              'to' => '1987-1-1'
            }
          ]
        }
      ]
      expect(JSON.parse(new_form_class.expand_provider_extras(providers).to_json)).to eq(
        [{
          'providerFacilityName' => 'provider 1',
          'providerFacilityAddress' => {
            'street' => '123 Main Street',
            'street2' => '1B',
            'city' => 'Baltimore',
            'state' => 'MD',
            'country' => 'USA',
            'postalCode' => '21200-1111'
          },
          'treatmentDateRange' => [
            {
              'from' => '1980-1-1',
              'to' => '1985-1-1'
            },
            {
              'from' => '1986-1-1',
              'to' => '1987-1-1'
            }
          ],
          'nameAndAddressOfProvider' => {
            'value' => '',
            'extras_value' => "provider 1\n123 Main Street\n1B\nBaltimore, MD, 21200-1111\nUSA"
          },
          'combinedTreatmentDates' => {
            'value' => '',
            'extras_value' => "from: 1980-1-1 to: 1985-1-1\nfrom: 1986-1-1 to: 1987-1-1"
          }
        }]
      )
    end
  end
end
