ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /<(input)/
    doc = Nokogiri::HTML::DocumentFragment.parse(html_tag)
    doc.children.add_class('error')
    doc.to_html.html_safe
  else
    html_tag
  end
end
