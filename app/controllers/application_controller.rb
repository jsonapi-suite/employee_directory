class ApplicationController < ActionController::API
  include JsonapiCompliable::Rails
  include JsonapiCompliable::Responders
end
