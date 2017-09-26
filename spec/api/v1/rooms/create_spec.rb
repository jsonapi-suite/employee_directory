require 'rails_helper'

RSpec.describe "rooms#create", type: :request do
  context 'basic create' do
    let(:payload) do
      {
        data: {
          type: 'rooms',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    it 'creates the resource' do
      expect {
        jsonapi_post "/api/v1/rooms", payload
      }.to change { Room.count }.by(1)
      room = Room.last

      assert_payload(:room, room, json_item)
    end
  end
end
