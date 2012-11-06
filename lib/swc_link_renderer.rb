require 'will_paginate/view_helpers/sinatra'

module SWC
  class Sinatra < WillPaginate::Sinatra::LinkRenderer
    ELLIPSIS = '&hellip;'

    def to_html
      list_items = pagination.map do |item|
        case item
          when Fixnum
            page_number(item)
          else
            send(item)
        end
      end

      tag('ul', list_items.join(@options[:link_separator]), :class => 'nav nav-tabs' )
    end

    protected

    def page_number(page)
      if page == current_page
        tag('li', link(page, page), :class => 'active')
      else
        tag('li', link(page, page, :rel => rel_value(page)))
      end
    end

    def gap
      tag('li', link(ELLIPSIS, '#'), :class => 'disabled')
    end

    def previous_page
      nil
    end

    def next_page
      nil
    end
  end
end
