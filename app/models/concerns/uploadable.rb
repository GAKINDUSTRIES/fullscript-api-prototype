module Uploadable
  extend ActiveSupport::Concern

  def file_url(args = nil)
    object = public_send(args[:object])
    object.url(args[:type]) if object.present?
  end
end
