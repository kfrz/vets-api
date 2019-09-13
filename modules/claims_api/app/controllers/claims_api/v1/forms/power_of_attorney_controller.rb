# frozen_string_literal: true

require_dependency 'claims_api/concerns/poa_verification'

module ClaimsApi
  module V1
    module Forms
      class PowerOfAttorneyController < ClaimsApi::BaseFormController
        include ClaimsApi::PoaVerification

        before_action { permit_scopes %w[claim.write] }
        before_action :validate_json_schema, only: %i[submit_form_2122]

        FORM_NUMBER = '2122'

        def submit_form_2122
          power_of_attorney = ClaimsApi::PowerOfAttorney.create(
            status: 'submitted',
            auth_headers: auth_headers,
            form_data: form_attributes,
            source: source_name
          )
          power_of_attorney = ClaimsApi::PowerOfAttorney.find_by(md5: power_of_attorney.md5) unless power_of_attorney.id
          power_of_attorney.set_file_data!(documents.first)
          power_of_attorney.save!

          render json: power_of_attorney, serializer: ClaimsApi::PowerOfAttorneySerializer
        end

        def status_2122; end

        private

        def source_name
          user = poa_request? ? @current_user : target_veteran
          "#{user.first_name} #{user.last_name}"
        end
      end
    end
  end
end