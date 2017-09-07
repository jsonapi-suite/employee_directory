class SerializableEmployee < JSONAPI::Serializable::Resource
  type :employees

  attribute :first_name
  attribute :last_name
  attribute :age
  attribute :created_at
  attribute :updated_at

  extra_attribute :meeting_duration

  has_many :positions
end
