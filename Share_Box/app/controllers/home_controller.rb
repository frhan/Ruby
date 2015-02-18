class HomeController < ApplicationController
  def index
    if user_signed_in?
      #load current_user's folders
      @folders = current_user.folders.roots

      #load current_user's files(assets)
      @assets = current_user.assets.where("folder_id is NULL").order("uploaded_file_file_name desc")
    end
  end

  def browse
    @current_folder = current_user.folders.find(params[:folder_id])
    if @current_folder
      @folders = @current_folder.children
      @assets = @current_folder.assets.order("uploaded_file_file_name desc")

      render action: 'index'
    else
      flash[:error] = "Don't be cheeky! Mind your own folders!"
      redirect_to root_url
    end
  end
end
