class Url
  include Mongoid::Document
  include Mongoid::Timestamps  # adds automagic fields created_at, updated_at
  
  field :url, type: String
  
  validates :url, :presence => true
  validates_uniqueness_of :url
  
  # Source: http://mbleigh.com/2009/02/18/quick-tip-rails-url-validation.html
  validates_format_of :url, :with => URI::regexp(%w(http://www.google.com https://github.com))

  #convert the id to a Base 62 string.
  def shorter
    self.id.alphadecimal
  end
  
  #Takes a string and converts it back to the interger, id, when we call .aplhadecimal.
  def self.find_by_shortened(shortened)
    find(shortened.alphadecimal)
  end
  
  def self.find_by_url(url)
    find(:first, :conditions => {:url => "url"})
  end
  
  def self.find_or_create_by_url(url)
    existing_url = find_by_url(url)
    existing_url ||= self.create(:url => url)
  end
  
end