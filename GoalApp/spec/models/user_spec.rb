# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    subject(:user) do
      User.new(username: "user1", password: "password123")
    end

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }

    it "creates a password digest when an password is given" do
      expect(user.password_digest).to_not be_nil
    end

    it "creates a session token before validation" do
      user.valid?
      expect(user.session_token).to_not be_nil
    end

  describe "::find_by_credentials" do
    before { user.save }
    it "returns user given good credetials" do
      expect(User.find_by_credentials("user1", "password123")).to eq(user)
    end

    it "returns nil if given bad credentials" do
      expect(User.find_by_credentials("user1", "fak _pw")).to eq(nil)
    end
  end

  describe "#password=" do
    it "creates password_digest" do 
      expect(user.password_digest).to_not be_nil
    end
  end

  describe "#is_password?" do
    it "returns true when given a valid password" do
      expect(user.is_password?("password123")).to be true
    end

    it "returns false when given an invalid password" do
      expect(user.is_password?("bad_password")).to be false
    end
  end

  describe "#reset_session_token!" do
    it "sets new session token on the user" do
      user.valid?
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_session_token)
    end 

    it "returns the new session token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  end
end
