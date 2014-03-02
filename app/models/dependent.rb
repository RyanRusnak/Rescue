class Dependent
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user


  field :dob, type: Date
  field :type, type: String
  field :location, type: String

  
  validates_presence_of :dob, :type

end