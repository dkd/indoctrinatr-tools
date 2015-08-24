require 'indoctrinatr/tools/version'
require 'redcloth_latex_formatter_patch/patch'

begin
  require 'pry'
rescue LoadError => e
  puts e.message
  # I think we can live without pry
end
