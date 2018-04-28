require 'rails_helper'
require './spec/controllers/helper_examples'

RSpec.describe CommentsController, type: :controller do
  
  include Devise::Test::ControllerHelpers

  describe "GET #edit" do
    include_examples 'redirecting_not_logged_in', :edit
  end


end
