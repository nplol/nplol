module FormHelper

  def simple_form_for(object, *args, &block)
    options = args.extract_options!
    form_for(object, *(args << options.merge(builder: SimpleFormBuilder)), &block)
  end

  class SimpleFormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::FormTagHelper
    include ActionView::Context

    def input(attribute, options={})
      content_tag(:section, class: "input #{attribute}") do
        if options[:image]
          @content = content_tag(:aside) do
            image_tag(options.delete(:image))
          end
        end
        @content << text_field(attribute, options)
      end
    end

  end

end
