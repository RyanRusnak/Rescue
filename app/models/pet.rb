class Pet
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  field :name, type: String
  field :type, type: String
  field :location, type: String

  validates_presence_of :type

end