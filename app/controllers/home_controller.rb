class HomeController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :except => [:index]

  def index
  end
end
