# frozen_string_literal: true

require 'rails_helper'
require 'support/saml/response_builder'

RSpec.describe SAML::User do
  include SAML::ResponseBuilder

  describe 'SSOe' do
    subject { described_class.new(saml_response) }

    let(:authn_context) { LOA::IDME_LOA1 }
    let(:account_type)  { '1' }
    let(:highest_attained_loa) { '1' }
    let(:multifactor) { false }

    let(:saml_response) do
      build_saml_response(
        authn_context: authn_context,
        account_type: account_type,
        level_of_assurance: [highest_attained_loa],
        multifactor: [multifactor],
        issuer: 'https://int.eauth.va.gov/FIM/sps/saml20fedCSP/saml20'
      )
    end

    context 'IDme LOA1 user' do
      it 'has various important attributes' do
        expect(subject.to_hash).to eq(
          dslogon_edipi: '1606997570',
          authn_context: authn_context,
          birth_date: nil,
          first_name: nil,
          last_name: nil,
          middle_name: nil,
          gender: nil,
          ssn: nil,
          zip: nil,
          mhv_icn: nil,
          mhv_correlation_id: nil,
          uuid: '0e1bb5723d7c4f0686f46ca4505642ad',
          email: 'kam+tristanmhv@adhocteam.us',
          multifactor: false,
          loa: { current: 1, highest: 1 },
          sign_in: { service_name: 'idme', account_type: 1 }
        )
      end

      it 'is not changing multifactor' do
        expect(subject).not_to be_changing_multifactor
      end
    end

    context 'MHV non premium user' do
      let(:authn_context) { 'myhealthevet' }
      let(:account_type) { '1' }
      let(:highest_attained_loa) { '3' }

      it 'has various important attributes' do
        expect(subject.to_hash).to eq(
          birth_date: nil,
          authn_context: authn_context,
          dslogon_edipi: '1606997570',
          first_name: nil,
          last_name: nil,
          middle_name: nil,
          gender: nil,
          ssn: nil,
          zip: nil,
          mhv_icn: nil,
          mhv_correlation_id: nil,
          uuid: '0e1bb5723d7c4f0686f46ca4505642ad',
          email: 'kam+tristanmhv@adhocteam.us',
          loa: { current: 1, highest: 3 },
          sign_in: { service_name: 'myhealthevet', account_type: 1 },
          multifactor: multifactor
        )
      end
    end

    context 'DSLogon non premium user' do
      let(:authn_context) { 'dslogon' }
      let(:account_type) { '1' }
      let(:highest_attained_loa) { '3' }

      it 'has various important attributes' do
        expect(subject.to_hash).to eq(
          birth_date: nil,
          authn_context: authn_context,
          dslogon_edipi: '1606997570',
          first_name: nil,
          last_name: nil,
          middle_name: nil,
          gender: nil,
          ssn: nil,
          zip: nil,
          mhv_icn: nil,
          mhv_correlation_id: nil,
          uuid: '0e1bb5723d7c4f0686f46ca4505642ad',
          email: 'kam+tristanmhv@adhocteam.us',
          loa: { current: 1, highest: 3 },
          sign_in: { service_name: 'dslogon', account_type: 1 },
          multifactor: multifactor
        )
      end
    end

    context 'DSLogon premium user' do
      let(:authn_context) { 'dslogon' }
      let(:account_type) { '3' }
      let(:highest_attained_loa) { '3' }

      it 'has various important attributes' do
        expect(subject.to_hash).to eq(
          birth_date: '1735-10-30',
          authn_context: authn_context,
          dslogon_edipi: '1606997570',
          first_name: 'Tristan',
          last_name: 'MHV',
          middle_name: '',
          gender: 'M',
          ssn: '111223333',
          zip: '12345',
          mhv_icn: '0000',
          mhv_correlation_id: '0000',
          uuid: '0e1bb5723d7c4f0686f46ca4505642ad',
          email: 'kam+tristanmhv@adhocteam.us',
          loa: { current: 3, highest: 3 },
          sign_in: { service_name: 'dslogon', account_type: 3 },
          multifactor: multifactor
        )
      end
    end
  end
end
