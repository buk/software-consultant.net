# encoding: utf-8
require "bundler/setup"

Bundler.require(:default, :test)

namespace :import do
  desc "Create project pages from projects.yml"
  task :projects do
    projects = YAML::load_documents(File.read('projects.yml'))
    projects.each do |project|
      name = project['start'].split('.').reverse
      name << project['title']
        .downcase
        .gsub('ö', 'oe')
        .gsub('ä', 'ae')
        .gsub('ü', 'ue')
        .gsub(/\W/, ' ')
        .strip
        .gsub(/\s+/, '-')

      content = <<EOF
Template: project
Customer: #{project['customer']}
Keywords: #{(%w{projekt} + project['tools'] + project['roles']).join(', ')}
Description: #{project['description'][/(\s*\S+){#{10}}/]}
Tools: #{project['tools'].join(', ')}
Roles: #{project['roles'].join(', ')}
Start: #{project['start']}
End: #{project['start']}

# #{project['title']}

#{project['description']}

EOF
      File.open("content/pages/projekte/#{name.join('-')}.mdown", 'w') do |f|
        f.write content
      end
    end
  end
end

