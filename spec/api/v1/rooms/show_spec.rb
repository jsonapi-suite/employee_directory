require 'rails_helper'

RSpec.describe "rooms#show", type: :request do
  context 'basic fetch' do
    let!(:room) { create(:room) }

    it 'serializes the resource correctly' do
      get "/api/v1/rooms/#{room.id}"

      assert_payload(:room, room, json_item)
    end
  end
end
