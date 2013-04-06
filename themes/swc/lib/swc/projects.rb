module SWC
  module PageAdditions
    def tools
      @tools ||= (metadata('tools') || '').split(',').map(&:strip)
    end

    def roles
      @roles ||= (metadata('roles') || '').split(',').map(&:strip)
    end

    def year
      @year ||= metadata('start') ? metadata('start').split('.').last.to_i : nil
    end
  end

  module Projects
    def self.registered(app)
      app.helpers do
        def projects
          @projects ||= ::Nesta::Page.find_all.select{|p| p.project?}.map{|p| p.send(:extend, PageAdditions)}
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
      end
    end
  end
end
