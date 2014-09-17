module FormHelper

  def label_form_for(object, *args, &block)
    options = args.extract_options!
    form_for(object, *(args << options.merge(builder: LabelFormBuilder)), &block)
  end

  class LabelFormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormTagHelper
    include ActionView::Context

    def input(attribute, options={})
      content_tag(:section, class: 'input') do
        if options[:optional]
          @content = label(attribute) do
            content_tag(:span, attribute.to_s.humanize) + content_tag(:span, ' (optional)', class: 'optional')
          end
        else
          @content = label(attribute)
        end
        @content << text_field(attribute, options)
      end
    end

    def file(attribute, options={})
      content_tag(:div, class: 'input') do
        label(attribute) + file_field(attribute, options)
      end
    end

    def text(attribute, options={})
      content_tag(:div, class:'input') do
        label(attribute) + text_area(attribute, options)
      end
    end

    def submit(*args)
      options = args.extract_options!

      content_tag(:button, type: 'submit') do

        if options[:icon]
          content_tag(:i, "", class: "fa fa-#{options[:icon]} fa-2x") +
          content_tag(:span) do
            options[:text]
          end
        else
          content_tag(:span) do
            options[:text]
          end
        end

      end # button content

    end # submit

  end

end
