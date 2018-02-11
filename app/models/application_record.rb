class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_commit :push

  def push
    payload = "Serializable#{self.class.name}".constantize.new(object: self)
    ActionCable.server.broadcast 'activity_channel',
      data: payload.as_jsonapi
  end
end
