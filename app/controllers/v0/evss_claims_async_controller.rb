# frozen_string_literal: true

module V0
  class EVSSClaimsAsyncController < ApplicationController
    include IgnoreNotFound

    before_action { authorize :evss, :access? }

    def index
      claims, synchronized = service.all
      render json: claims,
             serializer: ActiveModel::Serializer::CollectionSerializer,
             each_serializer: EVSSClaimListSerializer,
             meta: { sync_status: synchronized }
    end

    def show
      claim = EVSSClaim.for_user(current_user).find_by(evss_id: params[:id])
      raise Common::Exceptions::RecordNotFound, params[:id] unless claim

      claim, synchronized = service.update_from_remote(claim)
      render json: claim, serializer: EVSSClaimDetailSerializer,
             meta: { sync_status: synchronized }
    end

    private

    def service
      EVSSClaimServiceAsync.new(current_user)
    end
  end
end
