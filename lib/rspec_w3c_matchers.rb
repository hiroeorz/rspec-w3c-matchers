begin
  require "rubygems"
rescue
end

require "stringio"
require "w3c_validators"

class BeW3CValidHtml
  include W3CValidators

  @@charset = :utf8
  
  def initialize(format = nil)
    @html_validator = MarkupValidator.new
    @html_validator.set_charset!(@@charset)
    @html_validator.set_doctype!(format) if format
    @html_validator.set_debug!(true)
  end
  
  def matches?(target)
    if defined?(target.body)
      @target = StringIO.new(target.body.to_s)
    else
      @target = StringIO.new(target.to_s)      
    end

    @result = @html_validator.validate_file(@target)

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

  def BeW3CValidHtml.charset
    @@charset
  end

  def BeW3CValidHtml.charset=(value)
    @@charset = value
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

def be_html_401_strict
  BeW3CValidHtml.new(:xhtml401_strict)
end

def be_html_401_transitional
  BeW3CValidHtml.new(:xhtml401_transitional)
end

def be_html_401_frameset
  BeW3CValidHtml.new(:xhtml401_frameset)
end

def be_html_32
  BeW3CValidHtml.new(:html32)
end

def be_html_20
  BeW3CValidHtml.new(:html20)
end

def be_iso_html
  BeW3CValidHtml.new(:iso_html)
end

def be_xhtml_basic_10
  BeW3CValidHtml.new(:xhtml_basic10)
end

def be_xhtml_print_10
  BeW3CValidHtml.new(:xhtml_print10)
end

def be_xhtml_11_plus_mathml_20
  BeW3CValidHtml.new(:xhtml11_plus_mathml20)
end

def be_xhtml_11_plus_mathml_20_plus_svg_11
  BeW3CValidHtml.new(:xhtml11_plus_mathml20_plus_svg11)
end

def be_mathml_20
  BeW3CValidHtml.new(:mathml20)
end

def be_svg_10
  BeW3CValidHtml.new(:svg10)
end

def be_svg_11
  BeW3CValidHtml.new(:svg11)
end

def be_svg_11_tiny
  BeW3CValidHtml.new(:svg11_tiny)
end

def be_svg_11_basic
  BeW3CValidHtml.new(:svg11_basic)
end

def be_smil_10
  BeW3CValidHtml.new(:smil10)
end

def be_smil_20
  BeW3CValidHtml.new(:smil20)
end

# see http://code.dunae.ca/w3c_validators/doc
#
# W3CValidators#DOCTYPE
