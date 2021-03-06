# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PreneedsStateSerializer, type: :serializer do
  subject { serialize(preneeds_state, serializer_class: described_class) }

  let(:preneeds_state) { build :preneeds_state }
  let(:data) { JSON.parse(subject)['data'] }
  let(:attributes) { data['attributes'] }

  it 'includes id' do
    expect(data['id']).to eq(preneeds_state.id)
  end

  it 'includes the preneeds_state_id' do
    expect(attributes['preneeds_state_id']).to eq(preneeds_state.id)
  end

  it 'includes the code' do
    expect(attributes['code']).to eq(preneeds_state.code)
  end

  it 'includes the first_five_zip' do
    expect(attributes['first_five_zip']).to eq(preneeds_state.first_five_zip)
  end

  it 'includes the last_five_zip' do
    expect(attributes['last_five_zip']).to eq(preneeds_state.last_five_zip)
  end

  it 'includes the lower_indicator' do
    expect(attributes['lower_indicator']).to eq(preneeds_state.lower_indicator)
  end

  it 'includes the name' do
    expect(attributes['name']).to eq(preneeds_state.name)
  end
end
