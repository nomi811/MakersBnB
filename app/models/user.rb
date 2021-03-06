require 'bcrypt'
require 'dm-validations'

class User

  include DataMapper::Resource
  include BCrypt

  attr_reader :password
  attr_accessor :password_confirmation

  has n, :owned_spaces, 'Space', child_key: ['user_id']
  has n, :bookings
  has n, :rented_spaces, 'Space', through: :bookings, via: :space

  property :id, Serial
  property :name, String, required: true
  property :email, String, required: true, unique: true, format: :email_address
  property :password_digest, String, length: 60

  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end
