class SerializableEmployeeSearchResult < JSONAPI::Serializable::Resource
  type :employees

  attribute :first_name
  attribute :last_name
  attribute :created_at
  attribute :updated_at

  has_many :positions, class: 'SerializablePositionSearchResult'
end
