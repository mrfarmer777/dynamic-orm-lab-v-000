require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'interactive_record.rb'

class Student < InteractiveRecord

  def intitialize(options={})
    super
    options.each do |prop, value|
      attr_accessor prop.to_sym
    end
  end

end
