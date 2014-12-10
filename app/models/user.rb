class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter, :facebook, :google_oauth2]

  has_many :tasks


  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        if auth.provider == "twitter"
          user.email = "#{auth.info.nickname}@twitter.com"
        else
          user.email = auth.info.email
        end
        user.name = auth.info.name
        user.password = Devise.friendly_token[0,20]
        user.avatar = auth.info.image
      end
  end

end
