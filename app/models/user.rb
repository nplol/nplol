class User

  attr_accessor :name, :avatar

  def initialize(options = {})
    @name = options[:name]
    @avatar = options[:image]
  end

end
