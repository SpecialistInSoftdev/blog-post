# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/ 
  
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tag_list


  def should_generate_new_friendly_id?
    title_changed?
  end
  
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
end
