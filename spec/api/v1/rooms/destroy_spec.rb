require 'rails_helper'

RSpec.describe "rooms#destroy", type: :request do
  context 'basic destroy' do
    let!(:room) { FactoryGirl.create(:room) }

    it 'updates the resource' do
      expect {
        delete "/api/v1/rooms/#{room.id}"
      }.to change { Room.count }.by(-1)

      expect(response.status).to eq(204)
    end
  end
end
