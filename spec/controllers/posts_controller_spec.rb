require 'rails_helper'
require './spec/controllers/helper_examples'

RSpec.describe PostsController, type: :controller do
  
  describe "GET #index" do
    include_examples 'redirecting_not_logged_in', :index
  end
  
  describe "GET #edit" do
    include_examples 'redirecting_not_logged_in', :edit
  end
  
  describe "GET #new" do
    include_examples 'redirecting_not_logged_in', :new
  end
  
  describe "POST #create" do
    include_examples 'redirecting_not_logged_in', :create, :post
  end
  
  describe "DELETE #destroy" do
    include_examples 'redirecting_not_logged_in', :destroy, :delete
  end
  
  describe "GET #show" do
    include_examples 'redirecting_not_logged_in', :show
  end

end
