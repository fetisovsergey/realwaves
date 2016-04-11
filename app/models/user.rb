class User < ActiveRecord::Base
  
  ## Before create user generate token to activate user
  before_create :confirmation_token
  #########################################

  acts_as_voter  
  has_attached_file :avatar, :default_url => "default_avatar_:style.png",
 
  :styles => { :medium => "170x170#", :thumb => "25x25#" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  has_many :products
  
  has_many :votes, foreign_key: "voter_id", class_name:  "Vote", dependent:   :destroy
  has_many :voters, through: :votes, source: :voter

  before_save { self.email = email.downcase }
  before_save { self.name = name.downcase }
  before_create :create_remember_token

  VALID_NAME_REGEX = /\A([\w]+\_?[\w]+)*\z/i
  validates :name,  presence: true, format: { with: VALID_NAME_REGEX }, uniqueness: { case_sensitive: false }, length: { in: 3..18 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false },length: { maximum: 100 }

  has_secure_password
  validates :password, presence: true, :on => :create, length: { minimum: 6 }

  #VALID_REALNAME_REGEX = /\A(([A-Z\d]?[a-z\d]+\-?[A-Z\d]?[a-z\d]+)*|([А-Я\d]?[а-я\d]+\-?[А-Я\d]?[а-я\d]+)*)\z/
  #validates :realname, allow_blank: true, format: { with: VALID_REALNAME_REGEX }, length: { maximum: 20 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end    
  
  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def confirmation_token
      if self.confirm_token.blank?
      	self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end

