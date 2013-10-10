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

    klass = link.match(/([^\s]+)/)[0]
    link = link.match(/[^ ]* (.*)/)[1]

    image_tag(link, size: size, title: title, alt: alt_text, class: klass)

  end
end