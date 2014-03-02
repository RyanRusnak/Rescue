require "spec_helper"

describe Address do

	before(:each) do
	  @user = User.create({:email =>"testa@test.com", :first_name=>"first", :last_name=>"last", :password => 'password'})
	end

    it "should have a valid date of birth" do
      pending "write a test for dates"
    end

end