class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true
  validates :password_hash , :presence => true
  validate :email_valid?
  has_many :favorite_websites
  has_many :urls, :through => :favorite_websites


  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user && user.password == password
     user
    else
      nil
    end
  end

  def email_valid?
    if email.present? && email !~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
      errors.add(:email, "Email is invalid")
    end
  end
end


