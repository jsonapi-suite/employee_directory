class SerializableDepartment < JSONAPI::Serializable::Resource
  type :departments

  attribute :name

  has_many :rooms
  has_many :employees
end
