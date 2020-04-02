namespace :db do
  desc "It updates every user access token"

  task update_tokens: :environment do
    users = User.all 
    users.each { |user| AccessTokenRefresher.new.call(user) }
  end
end


