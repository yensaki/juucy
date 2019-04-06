class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i(twitter)
end
