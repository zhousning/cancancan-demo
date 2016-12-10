class ProductsController < InheritedResources::Base
  before_action :authenticate_user!
  load_and_authorize_resource

  private

    def product_params
      params.require(:product).permit(:name, :tag)
    end
end

