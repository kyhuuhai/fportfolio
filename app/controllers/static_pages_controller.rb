class StaticPagesController < ApplicationController
  def home
    @projects = Project.order_by_newest.limit Settings.limit_project
    @key = Settings.link_map + ENV["GOOGLE_API_KEY"]
  end
end
