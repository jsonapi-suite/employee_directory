class ElasticsearchAdapter < JsonapiCompliable::Adapters::Null
  def filter(scope, att, val)
    scope.condition(att).eq(val)
  end

  def paginate(scope, current_page, per_page)
    scope.metadata.pagination.current_page = current_page
    scope.metadata.pagination.per_page = per_page
    scope
  end

  def order(scope, att, dir)
    scope.metadata.sort = [{att: att, dir: dir}]
    scope
  end

  def resolve(scope)
    scope.query!
    scope.records.compact
  end

  module Sideloading
    def has_many(association_name,
                 scope:,
                 resource:,
                 foreign_key:,
                 primary_key: :id,
                 &blk)
      allow_sideload association_name,
        type: :has_many,
        resource: resource,
        foreign_key: foreign_key,
        primary_key: primary_key do
        scope do |parents|
          parent_ids = parents.map { |p| p.send(primary_key) }
          scope.call.condition(foreign_key).or(parent_ids.uniq.compact)
        end

        assign do |parents, children|
          parents.each do |p|
            relevant_children = children.select do |c|
              c.send(foreign_key) == p.send(primary_key)
            end
            p.send(:"#{association_name}=", relevant_children)
          end
        end
      end
    end
  end

  def sideloading_module
    Sideloading
  end
end
