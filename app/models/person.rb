require 'digest/sha1'

class Person < ActiveRecord::Base
  validates_confirmation_of :password
  validates_length_of :password, :in => 6..16
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :account_id
  validates_uniqueness_of :email, :scope => :account_id
  belongs_to :account  
  has_many :user_stories
  
  before_create :generate_activation_code
  before_save :hash_password
  
  def validate_account
    self.authenticated = 1
    self.activation_code = nil
    self.save
    return true
  end
  
  def authenticated?
    if self.authenticated == 1 && self.activation_code.nil?
      return true
    else
      return false
    end
  end
  
  def hash_password
    return false unless self.password
    self.salt = Digest::SHA1.hexdigest("#{Time.now}--#{PEOPLE_SALT}") if self.new_record? || self.salt.blank?
    self.hashed_password ||= Digest::SHA1.hexdigest("#{self.salt}--#{self.password}")
  end
  
  def encrypt(password)
    Digest::SHA1.hexdigest("#{self.salt}--#{password}")
  end
  
  def generate_temp_password
    self.password = Digest::SHA1.hexdigest("#{Time.now}---#{self.email}")[0..8]
  end
  
  def account_holder?
    self == self.account.account_holder
  end
  
  def can_delete_users?
    account_holder?
  end
  
  def self.basic_authenticate(email, password)
    self.find_by_email_and_password(email, password)
  end
  
  protected
  
  def generate_activation_code
    self.activation_code = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{self.email}--")
  end
end