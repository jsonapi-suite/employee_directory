class ApplicationResource < JsonapiCompliable::Resource
  self.abstract_class = true
  self.adapter = JsonapiCompliable::Adapters::ActiveRecord::Base.new
end
