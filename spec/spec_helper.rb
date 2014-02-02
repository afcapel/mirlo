require_relative '../lib/mirlo'
include Mirlo

Dir.glob(File.expand_path('../lib/mirlo/datasets/*.rb', File.dirname(__FILE__))).each do |f|
  require f
end

module SpecHelpers
  def fixture_file(name)
    File.join(specs_path, "fixtures", name)
  end

  def specs_path
    File.expand_path(File.dirname(__FILE__))
  end
end


RSpec.configure do |c|
  c.include SpecHelpers
end
