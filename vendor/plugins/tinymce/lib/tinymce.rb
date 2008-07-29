module TinyMce #:nodoc:
  
  module ViewHelpers
    
    def include_tiny_mce(options={}, &block)
       # TODO : allow options for holding configs in a yml file instead 
       options[:mode] ||= "specific_textareas"
       options[:class] ||= "editor"
       options[:theme] ||= "advanced"
       options[:convert_urls] ||= "false"
       options[:fonts] ||= "Arial=arial,helvetica,sans-serif;Courier New=courier new,courier,monospace"
       options[:text_colors] ||= "FF00FF,FFFF00,000000,818181,000066,e66f21,295223"
       options[:buttons] ||= "fontselect, fontsizeselect, forecolor, backcolor"
       options[:toolbar_location] ||= "top"
       
      content = javascript_include_tag('tiny_mce/tiny_mce')
       if block_given?
        # TODO : this should delegate processing to a hash processing method
       else
        content << "\n" 
        content << '<script language="javascript" type="text/javascript">'
        content << "\n" 
        content << '  tinyMCE.init({'
        content << "\n" 
        content << '  mode:"' << options[:mode] << '",'
        content << "\n" 
        content << '  theme:"' << options[:theme] << '",'
        content << "\n" 
        content << '  editor_selector:"' << options[:class] << '",'
        content << "\n" 
        content << '  convert_urls:"' << options[:convert_urls] << '",'
        content << "\n" 
        content << '  theme_advanced_fonts:"' << options[:fonts] << '",'
        content << "\n" 
        content << '  theme_advanced_toolbar_location:"' 
        content <<        options[:toolbar_location] << '",'
        content << "\n" 
        content << '  convert_fonts_to_spans: true,
                      theme_advanced_resizing : true});'
        content << "\n" 
        content << '</script>'
       end
       
       content
    end
    
  end
  
end