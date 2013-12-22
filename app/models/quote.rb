class Quote < Post

  validates_presence_of :quotee

  def self.model_name
    Post.model_name
  end

end