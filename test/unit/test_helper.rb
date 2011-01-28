require 'rubygems'
require 'bundler'

Bundler.setup :default, :development

require 'shoulda'
require 'mocha'

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..'))

require 'swc_parser'
require 'test/unit'

class Test::Unit::TestCase
  
  protected
  
  def fixtures
    File.expand_path(File.join(File.dirname(__FILE__), '..', 'fixtures'))
  end
  
end