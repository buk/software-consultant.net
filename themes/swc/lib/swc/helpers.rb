require 'uri'

module SWC
  module Helpers
    CHART_DEFAULTS = {type:'donut'}

    VOID_TAGS = %w{area base br col command embed hr img input keygen link meta param source track wbr}

    def menu_for(elements)
      elements = [elements] unless elements.is_a?(Array)
      elements.map do |e|
        opts = current_path?(e.path) ? {class:'active'} : nil
        content_tag :li, opts do
          content_tag(:a, href:url(e.path), title:e.link_text) do
            c = ''
            if icon = e.metadata(:icon)
              c << content_tag(:i, class:"icon-#{icon}")
              c << ' '
            end
            c << e.link_text
          end
        end
      end.join
    end

    def chart(title, data, options={})
      options.symbolize_keys!.reverse_merge!(CHART_DEFAULTS)
      content_tag :div, class:'chart-container' do
        c = content_tag(:div, title, class:'caption')
        opts = {
          values:data
        }
        %w{type xkey ykeys labels hidehover}.map(&:to_sym).each{|o| opts[o] = options[o] if options.key?(o)}
        c << content_tag(:div, '', class:'chart', data:opts)
      end
    end

    def maps_image
      u = URI.parse("http://maps.googleapis.com/maps/api/staticmap")
      opts = {
        center:'Auelsweg 22, 53797 Lohmar, Deutschland',
        maptype:'roadmap',
        scale:2,
        zoom:14,
        size:'866x140',
        markers:'color:red|Auelsweg 22, 53797 Lohmar, Deutschland',
        sensor:false
      }
      u.query = opts.map{|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join('&')
      content_tag :img, alt:'Map', src:u.to_s
    end

    def current_path?(path)
      return true if request.path.match("^/#{path}")
      false
    end

    def h(text)
      Rack::Utils.escape_html(text)
    end

    def debug(object)
      begin
        Marshal::dump(object)
        "<pre class='debug_dump'>#{h(object.to_yaml).gsub("  ", "&nbsp; ")}</pre>"
      rescue Exception  # errors from Marshal or YAML
        # Object couldn't be dumped, perhaps because of singleton methods -- this is the fallback
        "<code class='debug_dump'>#{h(object.inspect)}</code>"
      end
    end

    def placeholder(text, opts={})
      opts.symbolize_keys!.reverse_merge!(height:100, width:100)
      "<img src='http://placehold.it/#{opts[:width]}x#{opts[:height]}&text=#{URI.escape(text)}' alt='Placeholder'>"
    end

    def ext_link_to(content, uri, opts={})
      opts.merge! href:uri, rel:'nofollow'
      content_tag :a, content, opts
    end

    def content_tag(*args)
      opts = args.extract_options!
      type = args[0]
      content = (args[1] || '')
      s = "<#{type}"
      if attributes = to_attributes(opts)
        s << " #{attributes}"
      end
      s << ">"
      unless VOID_TAGS.include?(type.to_s)
        if block_given?
          s << yield
        else
          s << content
        end
        s << "</#{type}>"
      end
      s
    end

    private

    def to_attributes(options)
      return nil if options.nil?
      attrs = []
      options.each_pair do |k, v|
        if k.to_s == 'data' && v.is_a?(Hash)
          v.each do |k2, v2|
            unless v2.is_a?(String) || v2.is_a?(Symbol) || v2.is_a?(Numeric)
              v2 = v2.to_json
            end
            attrs << %(data-#{k2.to_s.dasherize}='#{v2}')
          end
        elsif !v.nil?
          final_value = v.is_a?(Array) ? v.join(" ") : v
          attrs << %(#{k}='#{final_value}')
        end
      end
      attrs.join(' ')
    end

  end
end
