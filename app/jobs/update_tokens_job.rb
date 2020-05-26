# frozen_string_literal: true

class UpdateTokensJob < ApplicationJob

  queue_as :default

  def perform
    User.all.each { |user| AccessTokenRefresher.new.call(user) }
    puts 'UPDATED'
  end

end
