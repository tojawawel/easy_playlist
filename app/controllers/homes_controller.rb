# frozen_string_literal: true

class HomesController < ApplicationController

  before_action :set_home, only: %i[show edit update destroy]
  def index; end

end
