require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do
    it "validates the presence of the user's email and password" do
      post :create, params: { user: { username: "test_user", password: ""} }
      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end

    it "validates that the password is at least 6 characters long" do
      post :create, params: { user: { username: "test_user", password: "123"} }
      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end

    it "redirects user to show page on success" do
      post :create, params: { user: { username: "test_user", password: "password123"} }
      user = User.find_by(username: "test_user")
      expect(response).to redirect_to(user_url(user))
    end 
  end

  describe "GET #new" do
    it "renders the new users template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #index" do
    it "renders the all users template" do 
      get :index
      expect(response).to render_template(:index)
    end
  end 

end
