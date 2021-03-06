# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DirectDepositMailer, type: [:mailer] do
  subject do
    described_class.build(email, google_analytics_client_id).deliver_now
  end

  let(:email) { 'foo@example.com' }
  let(:google_analytics_client_id) { '123456543' }

  describe '#build' do
    it 'includes all info' do
      expect(subject.subject).to eq('Confirmation - Your direct deposit information changed on VA.gov')
      expect(subject.to).to eq(['foo@example.com'])
      expect(subject.body.raw_source).to include(
        "We're sending this email to confirm that you've recently changed your direct deposit "\
        'information in your VA.gov account profile.'
      )
    end

    it 'delivers the mail' do
      expect { DirectDepositEmailJob.new.perform('test@example.com', 123_456_789) }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end
  end
end
