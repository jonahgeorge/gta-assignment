class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  validates_length_of :preferences, maximum: 5

  has_many :preferences
  has_and_belongs_to_many :skills

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create \
        email: data["email"],
        password: Devise.friendly_token[0,20],
        name: data["name"]
    end

    user
  end

  def is_admin?
    true
  end
end
