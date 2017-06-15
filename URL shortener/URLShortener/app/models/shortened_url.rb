class ShortenedUrl < ApplicationRecord

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

    has_many :topics,
      through: :taggings,
      source: :topic

    has_many :taggings,
      primary_key: :id,
      foreign_key: :user_id,
      class_name: :Tagging

  def self.create_shortenedurl(usr, str)
    short = ShortenedUrl.random_code
    ShortenedUrl.create! short_url: short, long_url: str, user_id: usr

  end


  def self.random_code
    code = SecureRandom.urlsafe_base64
    if ShortenedUrl.exists?(['short_url = ?', code])
      return ShortenedUrl.random_code
    end
    code
  end

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :visitor


  def num_clicks
    visits.count
  end

  #gives you the actual objects
  has_many :unique_visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  def num_uniques
    visi.select(:user_id).distinct.count
  end

  def num_recent_uniques
    recent_time = 10.minutes.ago

    visits.select(:user_id).distinct.where("created_at >= ?", recent_time).count
  end


end

#  SecureRandom::urlsafe_base64
