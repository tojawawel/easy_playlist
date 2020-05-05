class ImportFilesController < ApplicationController

  def new
    @import_file = ImportFile.new
  end

  def create
    @import_file = ImportFile.new(import_file_params)
    data = params[:import_file][:data]
    name = params[:import_file][:playlist_name]
    
    PlaylistAdder.new.call(name, data,auth_token)

    if @import_file.save
      flash[:success] = 'import_file was successfully created'
    else
      render 'new'
    end
  end

  
  private
  
  def auth_token
    EncryptionService.decrypt(current_user.token)
  end

  def import_file_params
    params.require(:import_file).permit(:data, :playlist_name)
  end
end

  def add_songs_to_playlist
    AddToPlaylistJob.perform_later(auth_token)
    redirect_to root_path, notice: 'Post was successfully created.'
  end
