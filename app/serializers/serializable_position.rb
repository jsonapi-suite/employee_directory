class SerializablePosition < JSONAPI::Serializable::Resource
  type :positions

  attribute :title do
    'asdf'
  end

  belongs_to :department
  has_many :employees
end
