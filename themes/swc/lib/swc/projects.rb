require 'json'

module SWC
  module PageAdditions
    def customer
      @customer ||= metadata('customer')
    end

    def start
      @start ||= metadata('start')
    end

    def end
      @end ||= metadata('end')
    end

    def tools
      @tools ||= (metadata('tools') || '').split(',').map(&:strip)
    end

    def roles
      @roles ||= (metadata('roles') || '').split(',').map(&:strip)
    end

    def year
      @year ||= start ? start.split('.').last.to_i : nil
    end
  end

  module Projects

    PARAM_NAMES =  %w{ title description customer roles tools }.map(&:to_sym)

    def self.registered(app)
      app.get '/projects.json' do
        content_type :json

        terms = {}
        max = params['max'] ? params['max'].to_i : 0

        PARAM_NAMES.each do |name|
          terms[name] = params[name] if params[name]
        end

        search_projects(terms.empty? ? nil : terms, max).to_json
      end

      app.helpers do
        def projects
          @projects ||= ::Nesta::Page.find_all.select{|p| p.project?}.map(&:as_project)
        end

        def project_stats
          @project_stats ||= {
            tools: begin
              h = Hash.new(0)
              projects.each do |p|
                p.tools.each { |tool| h[tool] += 1}
              end
              h.to_a.sort{|a,b| b[1]<=>a[1]}.first(10)
            end,
            roles: begin
              h = Hash.new(0)
              projects.each do |p|
                p.roles.each{|role| h[role.strip] += 1}
              end
              h
            end,
            years: begin
            end
          }
        end

        def projects_by_year
          @projects_by_year ||= begin
            projects.inject(Hash.new{|h, k| h[k]=Array.new}) do |h, p|
              h[p.year] << p
              h
            end.sort_by{|year, projects| year.to_i}.reverse
          end
        end

        def search_projects(terms, max=0)

          return projects[0..(max-1)] if terms.nil?
          terms = { :any=>terms } unless terms.is_a?(Hash)

          projects.reverse.find_all do |project|
            PARAM_NAMES.any? do |name|
              t = terms[name] || terms[:any]
              if t
                r1 = t.is_a?(Array) ? t.map{|term| Regexp.escape(term.to_s) }.join('|') : Regexp.escape(t.to_s)
                r2 = Regexp.new("\\b(#{r1})\\b", true)
                name = name.to_s
                v = case temp = project.send(name)
                  when nil then ''
                  when Array then temp.join(' ')
                  when String then temp
                  else temp.to_s
                end
                v =~ r2
              end
            end
          end[0..(max-1)]
        end


      end
    end
  end
end
