
# frozen_string_literal: true

module ClaimsApi
  class Form526
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    REQUIRED_FIELDS = %i[
      veteran
      applicationExpirationDate
      serviceInformation
      disabilities
    ].freeze

    BOOLEAN_REQUIRED_FIELDS = %i[
      claimantCertification
      standardClaim
    ].freeze

    OPTIONAL_FIELDS = %i[
      directDeposit
      servicePay
      treatments
    ].freeze

    attr_accessor *REQUIRED_FIELDS, *OPTIONAL_FIELDS
    attr_reader *BOOLEAN_REQUIRED_FIELDS

    validates *REQUIRED_FIELDS, presence: true
    validates *BOOLEAN_REQUIRED_FIELDS, inclusion: { in: [true, false] }

    def claimantCertification=(string_value)
      @claimantCertification = (string_value == '1')
    end

    def standardClaim=(string_value)
      @standardClaim = (string_value == '1')
    end

    def initialize(params = {})
      @attributes = []
      params.each do |name, value|
        @attributes << name.to_sym
        begin
          send("#{name}=", value)
        rescue StandardError
          errors.add(name, 'is not a valid attribute')
        end
      end
    end

    def persisted?
      false
    end

    def attributes
      @attributes.map { |method| { method => send(method) } }.reduce(:merge)
    end

    def to_internal
      raise cleaned_errors unless valid?
      {
        "form526": attributes,
        "form526_uploads": [],
        "form4142": nil,
        "form0781": nil,
        "form8940": nil
      }.to_json
    end

    private

    def cleaned_errors
      errors.messages.map { |key, value| "#{key} " + value.join(' and ') }.join(', ')
    end
  end
end
