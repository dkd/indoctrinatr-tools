require 'indoctrinatr/tools/version'

begin
  require 'pry'
rescue LoadError => e
  puts e.message
  # I think we can live without pry
end
