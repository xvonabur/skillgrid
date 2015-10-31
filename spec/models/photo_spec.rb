require 'rails_helper'

RSpec.describe Photo, type: :model do
  context 'validation' do
    it 'is not valid for > 1 Mb size image' do
      expect {
        image = File.open(Rails.root.join('spec/support/space.jpg'))
        create(:photo, image: image)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end


    it 'is valid for < 1 Mb size image' do
      expect {
        image = File.open(Rails.root.join('spec/support/lightsaber.png'))
        create(:photo, image: image)
      }.to_not raise_error
    end
  end
end
