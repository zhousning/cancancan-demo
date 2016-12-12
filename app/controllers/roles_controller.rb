class RolesController < ApplicationController
  before_action :authenticate_user!
  before_filter :is_super_admin?

  def new
    @role = Role.new
    @permissions = Permission.all
    @role_permissions = @role.permissions.collect{|p| p.id}
  end

  def create
    @role = Role.new(role_params)
    @permissions = Permission.find(params[:permissions]) if params[:permissions]
    @role.permissions << @permissions
    if @role.save
      redirect_to @role
    else
      render :new
    end
  end

  def index
    @roles = Role.all
  end

  def show
    @role = Role.find(params[:id])
    @permissions = @role.permissions
  end

  def edit
    @role = Role.find(params[:id])
    @permissions = Permission.all
    @role_permissions = @role.permissions.collect{|p| p.id}
  end

  def update
    @role = Role.find(params[:id])
    @permissions = Permission.find(params[:permissions]) if params[:permissions]
    @role.permissions << @permissions
    if @role.save
      redirect_to roles_path and return
    end
    @permissions = Permission.all
    render 'edit'
  end

  def destroy
  end

  #def index
  #  @roles = Role.all.keep_if{|i| i.name != "Super Admin"}
  #end
  #def edit
  #  @role = Role.find(params[:id])
  #  @permissions = Permission.all.keep_if{|i| ["Part"].include? i.subject_class}.compact
  #  @role_permissions = @role.permissions.collect{|p| p.id}
  #end

  #def update
  #  @role = Role.find(params[:id])
  #  @role.permissions = []
  #  @role.set_permissions(params[:permissions]) if params[:permissions]
  #  if @role.save
  #    redirect_to roles_path and return
  #  end
  #  @permissions = Permission.all.keep_if{|i| ["Part"].include? i.subject_class}.compact
  #  render 'edit'
  #end

  private

    def role_params
      params.require(:role).permit(:name)
    end

    def is_super_admin?
      redirect_to root_path and return unless current_user.super_admin?
    end
end
