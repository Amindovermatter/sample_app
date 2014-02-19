require 'spec_helper'


describe User do

  before (:each) do
	@attr = {:name => "Example User", 
		:email => "user@example.com",
		:password => "doodle",
		:password_confirmation => "doodle"}
  		end 

	describe "passwords" do
		
		before (:each) do
		   @user= User.new(@attr)
		end
		it "should have a password attribute" do
		  @user.should respond_to(:password)
		end

		it "should have a password confirmation" do
		  @user.should respond_to(:password_confirmation)
		end
	end
	describe "password validations" do
	   it "should require a password" do
		User.new(@attr.merge(:password=>"", :password_confirmation =>"")).should_not be_valid
		end 
	   it "should require a matching password confirmation"do
		User.new(@attr.merge(:password_confirmation 			=>"invalid")).should_not be_valid
		end
	   
	   it "should reject short passwords" do
		short = "n" *5
		hash = @attr.merge(:password=> short,:password_confirmation => short)
		User.new(hash).should_not be_valid
	        end

	    it "should reject very long passwords" do
		long = "n" *41
		long_hash = @attr.merge(:password=> long,:password_confirmation => long)
		User.new(long_hash).should_not be_valid
	        end
	end

	describe "password encryption" do
		before(:each) do
		   @user= User.create!(@attr)
		end 
		it "should have an encrypted password attribute" 			do @user.should respond_to(:encrypted_password) 		  			end
		
		it "should set the encrypted password attribute" 			do @user.encrypted_password.should_not be_blank
		end 
		
		it "should have a salt" do 
			@user.should respond_to(:salt)
		end
	
		describe "has_password? method" do
		   it "should exist" do
			@user.should respond_to(:has_password?)
				end
		   it "should return true if password matches" do
			@user.has_password?(@attr[:password]).should be_true 
		   end
		
		   it "should return false if password matches" 			do
			@user.has_password?("invalid").should be_false 
			end
		end 

		describe "authenticate method" do
		   it "should exist" do
			User.should respond_to(:authenticate)
		   end
		   it "should return nil on email/password mismatch" do
		User.authenticate(@attr[:email],"wrongpass").should be_nil
		   end
		   it "should return nil for an email with no user"do
		User.authenticate("bar@foo.com", @attr[:password]).should be_nil
		   end
		   it "should return the user on email/password match" do
		User.authenticate(@attr[:email], @attr[:password]).should ==@user
		   end
		end			
	end
end

		