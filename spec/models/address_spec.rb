require "spec_helper"

describe Address do

	before(:each) do
	  @user = User.create({:email =>"testa@test.com", :first_name=>"first", :last_name=>"last", :password => 'password'})
	end

    it "address does not need an apt number" do
      address = @user.addresses.create({:street=> "address st", :city => "test", :state => "test", :zip_code => '12345'})
      @user.reload.addresses.should eq([address])
    end
    it "address can have an apt number" do
      address = @user.addresses.create({:street=> "address st",:apt_number => "300", :city => "test", :state => "test", :zip_code => '12345'})
      @user.reload.addresses.should eq([address])
    end

end