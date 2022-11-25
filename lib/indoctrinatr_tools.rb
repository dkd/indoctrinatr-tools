require 'zeitwerk'
require 'dry/cli'

Zeitwerk::Loader.for_gem(warn_on_extra_files: false).tap do |loader|
  # loader.log!
  loader.ignore('lib/indoctrinatr/tools/version')
  loader.setup
end

Indoctrinatr::Tools::RedclothFormattersLatexPatch.apply

Dry::CLI.new(Indoctrinatr::Tools::Commands).call
