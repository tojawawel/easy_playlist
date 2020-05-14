# frozen_string_literal: true

class UpdateTokensJob < ApplicationJob

  queue_as :default

  def perform
    users = User.all
    users.each { |user| AccessTokenRefresher.new.call(user) }
    puts 'UPDATED'
  end

end
