# frozen_string_literal: true

require_dependency 'veteran_verification/notary'
require_dependency 'veteran_verification/application_controller'

module VeteranVerification
  module V0
    class DisabilityRatingController < ApplicationController
      include ActionController::MimeResponds

      before_action { authorize :evss, :access? }
      before_action { permit_scopes %w[disability_rating.read] }

      def index
        disabilities_response = service.get_rated_disabilities
        serialized = ActiveModel::SerializableResource.new(disabilities_response.rated_disabilities, 
                                                           each_serializer: VeteranVerification::DisabilityRatingSerializer)


        respond_to do |format|
          format.json { render json: serialized.to_json }
          format.jwt do
            notary = VeteranVerification::Notary.new(Settings.vet_verification.signing_key_path)
            token = notary.sign(serialized.serializable_hash)
            render body: token
          end
        end
      end

      private

      def service
        EVSS::DisabilityCompensationForm::Service.new(auth_headers)
      end

      def auth_headers
        headers = EVSS::DisabilityCompensationAuthHeaders.new(@current_user)
        headers.add_headers(EVSS::AuthHeaders.new(@current_user).to_h)
      end
    end
  end
end
