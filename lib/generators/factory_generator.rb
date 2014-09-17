class FactoryGenerator < Rails::Generators::Base
  argument :name

  def generate_file
    create_file "spec/factories/#{name.pluralize}.rb",
      "FactoryGirl.define do \n\n  factory :#{name.singularize} do\n\n  end\n\nend"
  end

end
