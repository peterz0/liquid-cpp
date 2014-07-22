require 'liquid/c/version'
require 'liquid'

# workaround bundler issue #2947 which could cause an old extension to be used
require 'rbconfig'
ext_path = File.expand_path("../../liquid_c.#{RbConfig::CONFIG['DLEXT']}", __FILE__)
if File.exists?(ext_path)
  require ext_path
else
  require 'liquid_c'
end

Liquid::Template.class_eval do
  private

  def tokenize(source)
    Liquid::Tokenizer.new(source.to_s)
  end
end

Liquid::Variable.class_eval do
  private

  def lax_parse(markup)
    parser = Liquid::VariableParse.new(markup)
    @name = parser.name
    @filters = parser.filters
  end
end

Liquid::Block.class_eval do
  def parse(tokens)
    @nodelist ||= []
    @nodelist.clear
    @children = []
    parser = Liquid::BlockParser.new(@blank, @nodelist, @children, tokens, @options, self)
  end
end
