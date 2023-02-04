class Url
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  validates :name, presence: true
  field :original_url, type: String
  validates :original_url, presence: true, length: { minimum: 8}
  field :short_url, type: String

  before_create :generate_short_url, :sanitize

  def generate_short_url
    rand(36**8).to_s(36)
  end

  def sanitize
    original_url.strip!
    sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
    "http://#{sanitize_url}"
  end

end
