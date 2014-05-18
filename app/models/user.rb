class User

  attr_accessor :name, :avatar

  def initialize(options = {})
    @name = options[:first_name]
    @avatar = options[:image]
  end

end
