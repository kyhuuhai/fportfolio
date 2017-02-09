class ProjectsController < ApplicationController
  before_action :authenticate_user!,only: [:create, :new, :update, :edit]

  def new
    @categories = Category.all
    @project = Project.new
    @project.images.build
  end

  def index
    @projects = Project.order_by_newest.page(params[:page])
      .per Settings.per_page.projects
  end

  def create
    @project = current_user.projects.new project_params
    check_private_attributes
    if current_user.save
      flash[:success] = t "projects.created"
      redirect_to users_path
    else
      @categories = Category.all
      flash[:danger] = t "images.create_failed"
      render :new
    end
  end

  def show
    @project = Project.find_by id: params[:id]
    @message = Message.new
    if @project
      @comments = @project.comments
      @like = @project.likes.find_by(user_id: current_user.id)
      @images = @project.images
      @members = @project.users.merge(Participate.accepted)
    else
      flash[:warning] = t "record_isnt_exist"
      redirect_to root_url
    end
  end

  def update
  end

  private
  def check_private_attributes
    private_value = Array.new
    Project::PRIVATE_ATTRIBUTES.each do |key, value|
      if params[key] == Settings.private
        private_value.push value
      end
    end
    @project.private_attributes = private_value.join(",")
  end

  def project_params
    params.require(:project).permit :name, :url, :description, :core_features, :pm_url,
      :realease_note, :git_repository, :server_information, :platform, :category_id,
      :pm_url, images_attributes: [:id, :image, :image_cache, :_destroy]
  end
end
