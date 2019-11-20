module NextRails
  class CLI::Next
    class << self
      GEMFILE="Gemfile".freeze
      GEMFILE_NEXT="Gemfile.next".freeze

      def init(rails_version: nil)
        add_dual_boot
      end

      private

      def add_dual_boot
        return false unless File.file?(GEMFILE)

        if File.symlink?(GEMFILE_NEXT)
          puts "#{GEMFILE_NEXT} already exists"
          return
        end

        new_gemfile = "#{GEMFILE}.new"

        File.open(new_gemfile, "w+") do |f|
          f.puts next_method_str unless next_method_defined?

          File.foreach(GEMFILE) do |line|
            if matches = line.match(/\Agem ("|')rails("|').*\Z/)
              conditional_rails_line = dual_boot_str(original_rails_version_line: matches[0])
              line = conditional_rails_line unless has_conditional_rails?
            end

            f.puts(line)
          end
        end

        File.rename(new_gemfile, GEMFILE)
        File.symlink(GEMFILE, GEMFILE_NEXT)
      end

      def has_conditional_rails?
        gemfile_content =~ /if next\?\n  gem "rails".*\nelse\n  gem "rails",.*\nend\n/
      end

      def next_method_defined?
         gemfile_content =~ /def next?/
      end

      def gemfile_content
        open(GEMFILE).read
      end

      def dual_boot_str(original_rails_version_line:)
        <<-STRING
if next?
  gem "rails", "6.0.0"
else
  #{original_rails_version_line}
end
        STRING
      end

      def next_method_str
        <<-STRING
def next?
  File.basename(__FILE__) == "Gemfile.next"
end
          STRING
      end
    end
  end
end
