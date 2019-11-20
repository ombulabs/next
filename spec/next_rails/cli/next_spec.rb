RSpec.describe NextRails::CLI::Next do
  subject { NextRails::CLI::Next }

  describe ".init" do
    it "creates Gemfile.next symlink" do
      gemfile_setup do
        subject.init
        expect(File.symlink?("Gemfile.next")).to be_truthy
      end
    end

    it "defines a next? method in Gemfile" do
      gemfile_setup do |gemfile|
        subject.init
        expect(open("Gemfile").read).to match(/def next?/)
      end
    end

    it "adds dual boot condition in Gemfile " do
      gemfile_setup do
        File.open("Gemfile", "w") { |f| f.puts("gem \"rails\", \"4.2.0\"") }

        subject.init
        expect(open("Gemfile").read).to match(/.*if next\?\n  gem "rails".*\nelse\n  gem "rails", "4.2.0"\nend\n/)
      end
    end

    it "does not add dual boot condition twice", :doku do
      gemfile_setup do
        gemfile_content = <<-STRING
if next?
  gem "rails", "6.0.0"
else
  gem "rails", "5.2.0"
end
        STRING

        File.open("Gemfile", "w") { |f| f.puts("def next?\n  File.basename(__FILE__) == \"Gemfile.next\"\nend\nif next?\n  gem \"rails\", \"6.0.0\"\nelse\n  gem \"rails\", \"4.2.0\"\nend\n") }

        subject.init
        expect(open("Gemfile").read).to eq("def next?\n  File.basename(__FILE__) == \"Gemfile.next\"\nend\nif next?\n  gem \"rails\", \"6.0.0\"\nelse\n  gem \"rails\", \"4.2.0\"\nend\n")
      end
    end
  end
end
