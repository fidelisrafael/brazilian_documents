require_relative 'ie/base'

Dir[File.expand_path("ie/{**/**,**}.rb", File.dirname(__FILE__))].each {|file| require file }