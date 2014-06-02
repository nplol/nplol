class Asset < ActiveRecord::Base

  belongs_to :article#, class_name: 'Post', foreign_key: 'post_id'

  has_attached_file :image, styles: { large: '640x480', medium: '300x300>', thumb: '100x100>' }

  validates_attachment_presence :image

  validates_attachment_content_type :image, content_type: 'image/png'

  def thumb_url
    image.url(:thumb)
  end

  def large_url
    image.url(:large)
  end

end
