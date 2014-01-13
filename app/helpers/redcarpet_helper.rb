module RedcarpetHelper

  def markdown(text)
    markdown = Redcarpet::Markdown.new(HTMLBlockCode, fenced_code_blocks: true) 
    markdown.render(text).html_safe
  end
  
end

# monkey patch for the HTML generation of RedCarpet to
# allow classes to be added to images.
class HTMLBlockCode < Redcarpet::Render::HTML
  include ActionView::Helpers::AssetTagHelper

  def image(link, title, alt_text)

    link_resources = link.split(/[ \|]/)

    url = link_resources.pop

    classes = ''

    link_resources.each do |klass|
      classes << ' '+klass
    end

    image_tag(url, title: title, alt: alt_text, class: classes.strip!)

  end
end