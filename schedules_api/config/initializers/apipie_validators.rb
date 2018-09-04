class IntegerValidator < Apipie::Validator::BaseValidator
  def initialize(param_description, argument)
    super(param_description)
    @type = argument
  end

  def validate(value)
    return false if value.nil?
    !!(value.to_s =~ /^[-+]?[0-9]+$/)
  end

  def self.build(param_description, argument, _options, _block)
    new(param_description, argument) if argument == Integer
  end

  def description
    "Must be #{@type}."
  end
end
