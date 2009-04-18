begin
  require "rubygems"
rescue
end

require "w3c_validators"

class BeW3CValidHtml
  include W3CValidators
  
  def initialize(format = nil)
    @html_validator = MarkupValidator.new
    @html_validator.set_charset!(:utf_8)
    @html_validator.set_doctype!(format) if format
    @html_validator.set_debug!(true)
  end
  
  def matches?(target)
    if defined?(target.body)
      @target = target.body
    else
      @target = target.to_s      
    end

    @result = @html_validator.validate_text(@target)

    print_warnings

    @result.is_valid?
  end

  def print_warnings
    warn_flg = false
    msg = "\n"
      
    @result.warnings.each do |e|
      next if e.to_s =~ /DOCTYPE Override in effect!/
      msg <<  "\n  #{e.to_s}\n";
      warn_flg = true
    end
    
    puts msg if warn_flg
  end
  
  def failure_message_for_should
    msg = "expected be xhtml 1.0 strict, but was not validated.\n"
    msg << "\n"
    
    @result.errors.each do |e|
      msg << "\n  #{e.to_s}\n"
    end
    
    msg
  end
  
  def failure_message_for_should_not
    "expected not be xhtml 1.0 strict, but was validated.\n"
  end
end

def be_valid_html(format = nil)
  BeW3CValidHtml.new(format)
end

def be_xhtml_10_strict
  BeW3CValidHtml.new(:xhtml10_strict)
end

def be_xhtml_10_transitional
  BeW3CValidHtml.new(:xhtml10_transitional)
end

def be_xhtml_10_frameset
  BeW3CValidHtml.new(:xhtml10_frameset)
end

def be_xhtml_11
  BeW3CValidHtml.new(:xhtml11)
end

def be_xhtml_basic_10
  BeW3CValidHtml.new(:xhtml_basic10)
end

# see http://code.dunae.ca/w3c_validators/doc
#
# W3CValidators#DOCTYPE
