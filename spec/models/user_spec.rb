require "spec_helper"

describe User do

	before(:each) do
	  @user = User.create({:email =>"testa@test.com", :first_name=>"first", :last_name=>"last", :password => 'password'})
	end

    it "can have multiple pets" do
      
      pet1 = @user.pets.create({:type=>"corgy"})
      pet2 = @user.pets.create({:type=>"corgy"})
      @user.reload.pets.should eq([pet1, pet2])
    end

    it "can have multiple addresses" do
      
      address1 = @user.addresses.create({:street=> "address st", :city => "test", :state => "test", :zip_code => '12345'})
      address2 = @user.addresses.create({:street=> "address st", :city => "test", :state => "test", :zip_code => '12345'})
      @user.reload.addresses.should eq([address1, address2])
    end

    it "can have multiple dependents" do
      
      dependent1 = @user.dependents.create({:dob => "01/01/1111", :type =>"child"})
      dependent2 = @user.dependents.create({:dob => "01/01/1111", :type =>"child"})
      @user.reload.dependents.should eq([dependent1, dependent2])
    end

end