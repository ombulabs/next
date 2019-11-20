require "thor"

module NextRails
  class CLI < Thor
    require_relative "cli/next"
    require_relative "cli/report"

    desc "exec", "Execute user provided commands in the \"bundle\" context", hide: true
    def exec(cmd)
      NextRails::CLI::Next.exec(cmd: cmd)
    end

    desc "init", "Configure dual booting"
    option "rails-version", type: :string
    def init
      NextRails::CLI::Next.init(rails_version: options["rails-version"])
    end

    desc "outdated", "Check which gems are outdated in your \"bundle\""
    def outdated
      NextRails::CLI::Report.outdated
    end

    desc "compatibility", "Check if your current \"bundle\" is compatible with a specific version of Ruby on Rails"
    option "rails-version", type: :string
    def compatibility
      unless options["rails-version"]
        puts "Specify a rails version with \"--rails-version\""
        exit(1)
      end

      NextRails::CLI::Report.compatibility(rails_version: options[:rails_version], include_rails_gems: false)
    end
  end
end
