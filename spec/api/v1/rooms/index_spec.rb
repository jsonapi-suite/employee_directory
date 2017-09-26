require 'rails_helper'

RSpec.describe "rooms#index", type: :request do
  context 'basic fetch' do
    let!(:room1) { create(:room) }
    let!(:room2) { create(:room) }

    it 'serializes the list correctly' do
      get "/api/v1/rooms"

      expect(json_ids(true)).to match_array([room1.id, room2.id])
      assert_payload(:room, room1, json_items[0])
      assert_payload(:room, room2, json_items[1])
    end
  end
end
