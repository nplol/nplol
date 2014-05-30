class Meme < Post
  has_attached_file :image, styles: { large: '640x480', medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :image, :content_type => /^image\/(png|gif|jpeg|jpg)/

  validates_attachment_presence :image

  def self.model_name
    Post.model_name
  end

end
