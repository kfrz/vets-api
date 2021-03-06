# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormAttachment do
  let(:preneed_attachment) { build(:preneed_attachment) }

  describe '#set_file_data!' do
    it 'stores the file and set the file_data' do
      expect(preneed_attachment.parsed_file_data['filename']).to eq('extras.pdf')
    end
  end

  describe '#get_file' do
    it 'gets the file from storage' do
      preneed_attachment.save!
      preneed_attachment2 = Preneeds::PreneedAttachment.find(preneed_attachment.id)
      file = preneed_attachment2.get_file

      expect(file.exists?).to eq(true)
    end
  end
end
