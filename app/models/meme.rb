class Meme < Post
  has_attached_file :image, styles: { large: '640x480', medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :image, :content_type => /^image\/(png|gif|jpeg|jpg)/
  validates :title, 	presence: true,
            length: {minimum: 5},
            uniqueness: true

  # awesome hack: http://stackoverflow.com/questions/4507149/best-practices-to-handle-routes-for-sti-subclasses-in-rails
  def self.model_name
    Post.model_name
  end

end