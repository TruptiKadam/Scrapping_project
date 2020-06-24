class Hotel < ActiveRecord::Base
  validates :name, presence: true
end
