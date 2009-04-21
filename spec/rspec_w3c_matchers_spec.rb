require File.join(File.dirname(__FILE__), 'spec_helper')

describe "RspecW3cMatchers" do
  it "should failure XHTML 10 Strict" do
    FAILURE_XHTML_10_STRICT =<<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
  <head>
    <title>Fresh Merb App</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="/stylesheets/master.css" type="text/css" media="screen" charset="utf-8" />
  </head>
  <body>
    HELLO
  </body>
</html>
EOF

    FAILURE_XHTML_10_STRICT.should_not be_xhtml_10_strict
    FAILURE_XHTML_10_STRICT.should_not be_valid_html(:xhtml10_strict)

    FAILURE_XHTML_10_STRICT.should_not be_valid_html

  end

  it "should success XHTML 10 Strict" do
    SUCCESS_XHTML_10_STRICT =<<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
  <head>
    <title>Fresh Merb App</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="/stylesheets/master.css" type="text/css" media="screen" charset="utf-8" />
  </head>
  <body>
    <p>HELLO</p>
  </body>
</html>
EOF

    SUCCESS_XHTML_10_STRICT.should be_xhtml_10_strict
    SUCCESS_XHTML_10_STRICT.should be_valid_html(:xhtml10_strict)

    SUCCESS_XHTML_10_STRICT.should be_xhtml_10_transitional
    SUCCESS_XHTML_10_STRICT.should be_valid_html(:xhtml10_transitional)

    SUCCESS_XHTML_10_STRICT.should be_valid_html
  end

  it "should success XHTML 10 Strict over 3000byte data" do
    LONG_XHTML_10_STRICT =<<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">                          
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">                                                                    
  <head>                                                                                                                               
    <title>Fresh Merb App</title>                                                                                                      
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />                                                              
    <link rel="stylesheet" href="/stylesheets/master.css" type="text/css" media="screen" charset="utf-8" />                            
  </head>                                                                                                                              
  <body>                                                                                                                               
    <p>#{'H' * 1024}</p>                                                                                                                       
  </body>                                                                                                                              
</html>                                                                                                                                
EOF

    LONG_XHTML_10_STRICT.should be_xhtml_10_strict
    LONG_XHTML_10_STRICT.should be_valid_html(:xhtml10_strict)

    LONG_XHTML_10_STRICT.should be_xhtml_10_transitional
    LONG_XHTML_10_STRICT.should be_valid_html(:xhtml10_transitional)

    LONG_XHTML_10_STRICT.should be_valid_html
  end

  it "should settable character encoding" do
    BeW3CValidHtml.charset = :utf8
    BeW3CValidHtml.charset.should == :utf8

    BeW3CValidHtml.charset = :sjis
    BeW3CValidHtml.charset.should == :sjis
  end
end
