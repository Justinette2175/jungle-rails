require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:example) do
      @valid_user = User.new(first_name: "Sophie", last_name: "Smith", email:"sophie@hello.com", password: "sophie", password_confirmation: "sophie")
      @valid_user.save
    end
    it "should not allow two users with same email addresses" do
      @same_email = User.new(first_name: "Sophie", last_name: "Smith", email:"sophie@HELLO.COM", password: "sophie", password_confirmation: "sophie")
      @same_email.save
      expect(@same_email.errors.full_messages.include?("Email has already been taken")).to eql true


    end
    describe 'password' do
      it "password field must be filled out" do
        @no_password = User.new(first_name: "Sophie", last_name: "Smith", email:"sophie@hello.com", password_confirmation: "sophie")
        expect(@no_password.password).to be_falsey
      end
      it "password_confirmation field must be filled out" do
        @no_password_conf = User.new(first_name: "Sophie", last_name: "Smith", email:"sophie@hello.com", password: "sophie")
        expect(@no_password_conf.password_confirmation).to be_falsey
      end
      it "should match password with password confirmation" do
        @no_match = User.new(first_name: "Sophie", last_name: "Smith", email:"sophie@hello.com", password: "sophie", password_confirmation: "sophiee")
        expect(@no_match.valid?).to be_falsey
      end
      it "should be at least 6 characters" do
        @short_pwrd = User.new(first_name: "Sophie", last_name: "Smith", email:"sophie@hello.com", password: "soph", password_confirmation: "soph")
        @short_pwrd.save
        expect(@short_pwrd.errors.full_messages.include?("Password is too short (minimum is 6 characters)")).to eql true
      end
    end
    describe 'first_name' do
      it "should be present upon new user" do
        @no_first_name = User.new(first_name: "", last_name: "Smith", email:"sophie@hello.com", password: "sophie", password_confirmation: "sophie")
        @no_first_name.save
        expect(@no_first_name.errors.full_messages.include?("First name can't be blank")).to eql true
      end
    end
    describe 'last_name' do
      it "should be present upon new user" do
        @no_last_name = User.new(first_name: "Sophie", last_name: "", email:"sophie@hello.com", password: "sophie", password_confirmation: "sophie")
        @no_last_name.save
        expect(@no_last_name.errors.full_messages.include?("Last name can't be blank")).to eql true
      end
    end
    describe 'email' do
      it "should be present upon new user" do
        @no_email = User.new(first_name: "Sophie", last_name: "Smith", email:"", password: "sophie", password_confirmation: "sophie")
        @no_email.save
        expect(@no_email.errors.full_messages.include?("Email can't be blank")).to eql true
      end
    end

    describe ".authenticate_with_credentials" do
      it "should authenticate valid users" do
        test_user = User.authenticate_with_credentials("sophie@hello.com", "sophie")
        tested_user = User.find_by(email: "sophie@hello.com")
        expect(test_user).to eql tested_user
      end
      it "should be case insensitive" do
        test_user = User.authenticate_with_credentials("sophie@HELLO.com", "sophie")
        tested_user = User.find_by(email: "sophie@hello.com")
        expect(test_user).to eql tested_user
      end
      it "should ignore white space" do
        test_user = User.authenticate_with_credentials("sophie@hello.com  ", "sophie")
        tested_user = User.find_by(email: "sophie@hello.com")
        expect(test_user).to eql tested_user
      end
    end
  end
end
