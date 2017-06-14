class ShortenedUrl < ApplicationRecord

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

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





end

#  SecureRandom::urlsafe_base64
