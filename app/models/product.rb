class Product < ActiveRecord::Base
  belongs_to :user

  acts_as_votable
  has_many :votes, foreign_key: "votable_id", dependent: :destroy
  has_many :votables, through: :votes, source: :votable 
  default_scope -> { order('created_at DESC') }


  has_attached_file :photo1, :styles => { :full => "1600x800#", :medium => "800x600#", :icon => "100x100#" }
  validates_attachment_content_type :photo1, :content_type => /\Aimage\/.*\Z/
  validates_attachment :photo1, :presence => true, :size => { :less_than => 10.megabytes, :greater_than => 200.kilobytes }
  
  has_attached_file :photo2, :styles => { :full => "1600x800#", :medium => "800x600#" }, :default_url => ""
  validates_attachment_content_type :photo2, :content_type => /\Aimage\/.*\Z/
  validates_attachment :photo2, :allow_blank => true, :size => { :less_than => 10.megabytes, :greater_than => 200.kilobytes }

  has_attached_file :photo3, :styles => { :full => "1600x800#", :medium => "800x600#" }, :default_url => ""
  validates_attachment_content_type :photo3, :content_type => /\Aimage\/.*\Z/
  validates_attachment :photo3, :allow_blank => true, :size => { :less_than => 10.megabytes, :greater_than => 200.kilobytes }

  has_attached_file :photo4, :styles => { :full => "1600x800#", :medium => "800x600#" }, :default_url => ""
  validates_attachment_content_type :photo4, :content_type => /\Aimage\/.*\Z/
  validates_attachment :photo4, :allow_blank => true, :size => { :less_than => 10.megabytes, :greater_than => 200.kilobytes }

  has_attached_file :photo5, :styles => { :full => "1600x800#", :medium => "800x600#" }, :default_url => ""
  validates_attachment_content_type :photo5, :content_type => /\Aimage\/.*\Z/
  validates_attachment :photo5, :allow_blank => true, :size => { :less_than => 10.megabytes, :greater_than => 200.kilobytes }
  
  # Заголовок статьи
  validates :title, presence: true, length: { maximum: 20, minimum: 3 }

  # Ссылка на компанию
  #VALID_LINK_REGEX = /\A[\w+\-.]+\.[a-z]+\z/i
  validates :link, presence: true, length: { maximum: 50, minimum: 3 }
  before_save { self.link = link.downcase }

  # Контент
  validates :content, presence: true, length: { maximum: 5000, minimum: 500 }
  
  # Название компании
  validates :company_name, presence: true, length: { maximum: 20, minimum: 2 }

  # Статус лота
  validates :status, presence: true, format: { with: /[1-4]/}

  # Главная категория
  validates :category1, presence: true, format: { with: /[1-6]/}

  def product_activate
    self.available = true
    save!(:validate => false)
  end

  def product_deactivate
    self.available = false
    save!(:validate => false)
  end

  def voting?(user)
    votes.find_by(voter_id: user.id)
  end
  
  def self.search(query)
    where("title like ? or content like ?", "%#{query}%","%#{query}%") 
  end

end

