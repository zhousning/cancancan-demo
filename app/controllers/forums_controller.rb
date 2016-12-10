class ForumsController < InheritedResources::Base
  before_action :authenticate_user!
  load_and_authorize_resource

  private

    def forum_params
      params.require(:forum).permit(:title, :content)
    end
end

