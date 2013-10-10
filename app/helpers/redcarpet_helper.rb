module RedcarpetHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(HTMLBlockCode, fenced_code_blocks: true) 
    markdown.render(text).html_safe
  end
end

class HTMLBlockCode < Redcarpet::Render::HTML
  include ActionView::Helpers::AssetTagHelper

  def image(link, alt_text, title)
    size = nil
    klass = nil

    puts "LINK"
    puts link.inspect

    # bilder har format: ![alt text] (class src)
    klass = link.match(/([^\s]+)/)[0]
    puts "KLASS"
    puts klass.inspect  
    link = link.match(/[^ ]* (.*)/)[1]

    image_tag(link, size: size, title: title, alt: alt_text, class: klass)

  end
end