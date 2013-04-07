module Nesta
  class Page
    def author
      @author ||= Config.author
    end

    def project?
      flagged_as?('project')
    end

    def as_project(&block)
      send(:extend, ::SWC::PageAdditions) unless singleton_class.included_modules.include?(::SWC::PageAdditions)
      if block_given?
        yield self
      end
      self
    end

    def to_json(options=nil)
      {
        title:title,
        url:abspath
      }.merge(@metadata).to_json(options)
    end

  end
end
