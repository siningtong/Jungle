class User < ActiveRecord::Base
  has_secure_password

   validates :first_name, presence: true
   validates :last_name, presence: true
   validates :email, presence: true, uniqueness: {case_sensitive: false}
   validates :password, presence: true, on: :create, length: { minimum: 6 }
   validates :password_confirmation, presence: true, on: :create
   validates :password, confirmation: true
   validates :password_confirmation, confirmation: true

   def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    if user && user.authenticate(password)
       user
    else 
      nil
    end
  end
end
