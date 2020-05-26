# frozen_string_literal: true

class AdditionsController < ApplicationController

  def new
    @addition = Addition.new
  end

  def create
    @addition = Addition.new(addition_params)
    data = params[:addition][:data]
    name = params[:addition][:playlist_name]

    AddSongsToPlaylist.new(name, data, auth_token).call

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
