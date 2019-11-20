require "tmpdir"

module NextRails
  module Rspec
    module Helpers
      def gemfile_setup
        Dir.mktmpdir do |dir|
          Dir.chdir(dir) do
            File.open("Gemfile", "w")
            yield if block_given?
          end
        end
      end
    end
  end
end
