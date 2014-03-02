class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user


  field :street, type: String
  field :apt_number, type: String
  field :city, type: String
  field :state, type: String
  field :zip_code, type: String

  
  validates_presence_of :street, :city, :state, :zip_code

end
