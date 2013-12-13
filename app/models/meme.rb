class Meme < Post
  has_attached_file :image, styles: { large: '640x480', medium: '300x300>', thumb: '100x100>' }

  validates_attachment_content_type :image, :content_type => /^image\/(png|gif|jpeg|jpg)/
  validates :title, 	presence: true,
            length: {minimum: 5},
            uniqueness: true

  def initialize(options={})
    super
    self.type ||= 'meme'
  end

end