# a quick and easy class factory
class QuickClass
  # main public method - define attributes for a class
  def self.attributes=(**keyvals)
    # if attributes is already defined, delete the attr_accessor methods
    @attributes&.each_key { |k| [:"#{k}", :"#{k}="].each &method(:undef_method) }
    # define attributes at the keyvals passed to this method as an argument,
    # merged with the attributes of the superclass, if there is one.
    @attributes = keyvals.merge(superclass&.attributes || {})
    # define public attr_accessor methods for all the attributes
    attr_accessor *@attributes.keys
    # define a .default method that invokes #initialize with .attributes
    define_singleton_method(:default) { |**opts| new @attributes.merge(opts) }
  end
  # read default attributes
  def self.attributes; @attributes; end
  # configure attributes from #initialize.
  # note that defaults are not set here. Use .default for that.
  def initialize(opts={})
    opts.each { |k,v| instance_variable_set("@#{k}", v) }
  end
end

# See README.md for usage example