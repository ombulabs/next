require "thor"

module NextRails
  class CLI < Thor
    require_relative "cli/report"

    desc "report", "Report of your current \"bundle\""
    option :compatibility, aliases: "-c", type: :boolean
    option :outdated, aliases: "-o", type: :boolean
    def report
      NextRails::CLI::Report.compatibility if options[:compatibility]
      NextRails::CLI::Report.outdated if options[:outdated]
    end
  end
end
