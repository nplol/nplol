class Quote < Post

  def model.name
    Post.model_name
  end

end