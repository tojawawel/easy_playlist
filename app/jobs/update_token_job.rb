# frozen_string_literal: true

class UpdateTokenJob < ApplicationJob

  queue_as :default

  def perform
    User.all.each { |user| AccessTokenRefresher.new(user).call }
    puts 'UPDATED'
  end

end
