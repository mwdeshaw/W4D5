require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    before(:each) do
      user = User.create(username: "test_user", password: "password123")
    end

   describe "POST #create" do
    it "redirects to signup page if user does not exist and flash errors" do
      post :create, params: { user: { username: "test_user", password: ""} }
      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end

    it "redirects user to show page on successful log in" do
      post :create, params: { user: { username: "test_user", password: "password123"} }
      user = User.find_by(username: "test_user")
      expect(session[:session_token]).to eq(user.session_token)
      expect(response).to redirect_to(user_url(user))
    end 
  end

  describe "GET #new" do
    it "renders the new session template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  # describe "DELETE #destroy" do
  #   # before(:each) do
  #   #   user = User.create(username: "test_user", password: "password123")
  #   # end
  #   it "sets the session[:session_token] to nil" do 
  #     user = User.create(username: "test_user", password: "password123")
  #     delete :destroy, params: { id: user.id }
  #     expect(session[:session_token]).to be nil
  #   end
  #   it "redirects to log in page" do
  #     user = User.create(username: "test_user", password: "password123")
  #     delete :destroy, params: { id: user.id }
  #     expect(response).to redirect_to(new_session_url)
  #   end
  #   it "resets user's session token" do
  #     user = User.create(username: "test_user", password: "password123")
  #     log_in_user!(user)
  #     oldToken = user.session_token
  #     delete :destroy, params: { id: user.id }
  #     expect(user.session_token).to_not eq(oldToken)
  #   end
  # end 
end
