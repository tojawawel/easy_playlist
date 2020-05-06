class AdditionsController < ApplicationController

  def new
    @addition = Addition.new
  end

  def create
    @addition = Addition.new(addition_params)
    data = params[:addition][:data]
    name = params[:addition][:playlist_name]
    
    PlaylistAdder.new.call(name, data,auth_token)

    if @addition.save
      flash[:success] = 'addition was successfully created'
    else
      render 'new'
    end
  end

  
  private
  
  def auth_token
    EncryptionService.decrypt(current_user.token)
  end

  def addition_params
    params.require(:addition).permit(:data, :playlist_name)
  end
end

  def add_songs_to_playlist
    AddToPlaylistJob.perform_later(auth_token)
    redirect_to root_path, notice: 'Post was successfully created.'
  end
