class PositionResource < ApplicationResource
  use_adapter ElasticsearchAdapter
  type :positions
  model Position

  allow_filter :title_prefix do |scope, value|
    scope.condition(:title).starts_with(value)
  end
end
