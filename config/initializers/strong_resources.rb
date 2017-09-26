StrongResources.configure do
  strong_resource :room do
    # Your attributes go here, e.g.
    # attribute :name, :string
  end

  strong_param :object,
    swagger: :object,
    type: ActionController::Parameters.map

  strong_resource :employee do
    attribute :first_name, :string
    attribute :last_name, :string
    attribute :age, :integer
    attribute :profile_photo, :object
  end

  strong_resource :position do
    attribute :title, :string
  end

  strong_resource :department do
    attribute :name, :string
  end
end
