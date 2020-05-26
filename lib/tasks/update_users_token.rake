# frozen_string_literal: true

namespace :db do
  desc 'It updates every user access token'

  task update_token: :environment do
    User.all.each { |user| AccessTokenRefresher.new(user).call }
  end
end
