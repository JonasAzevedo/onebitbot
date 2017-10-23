require "pg_search"
include PgSearch

class Link < ActiveRecord::Base
  validates_presence_of :link

  has_many :link_hashtags
  has_many :hashtags, through: :link_hashtags
  belongs_to :company

  # include PgSearch
  pg_search_scope :link_search, :against => [:link]
end
