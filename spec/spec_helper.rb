require_relative '../lib/mirlo'
include Mirlo

Dir.glob(File.expand_path('../lib/mirlo/datasets/*.rb', File.dirname(__FILE__))).each do |f|
  require f
end
