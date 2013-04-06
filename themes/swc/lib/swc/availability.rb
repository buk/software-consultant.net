require 'json'

module SWC
  module Availability

    def self.registered(app)
      app.get '/availability.json' do
        content_type :json
        availability.to_json
      end

      app.helpers do
        def availability
          {
            :free => 0.1,
            :next_full => Date.new(2013, 5, 1),
            :valid_from => File.mtime(__FILE__)
          }
        end
      end
    end

  end
end
