class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
end
