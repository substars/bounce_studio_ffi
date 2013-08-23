require 'test_helper'

class BounceStudioTest < Test::Unit::TestCase

  def setup
    license_code = BS_LICENSE
    @studio = BoogieTools::BounceStudio.new license_code
    @raw = IO.read File.join(File.dirname(__FILE__), "raw_message.txt")
  end
  
  def test_truth
    assert true
  end

  def test_studio_type
    assert_equal Object, BoogieTools::BounceStudio.superclass
    assert_equal BoogieTools::BounceStudio, @studio.class
  end

  def test_check
    bounce_code = @studio.check(@raw)
    assert bounce_code.is_a?(Fixnum)
    assert_equal bounce_code, 10
  end
  
  def test_body
    body = @studio.body(@raw)
    assert body.is_a?(String) 
  end

  def test_from_address
    from_address = @studio.from_address(@raw)
    assert from_address.is_a?(String)
    assert !from_address.empty?
    assert_equal from_address, "MAILER-DAEMON@mail.coinet.com".downcase
  end

  def test_from_friendly_name
    from_friendly_name = @studio.from_friendly_name(@raw)
    assert from_friendly_name.is_a?(String)
    assert from_friendly_name.empty?
  end

  def test_header
    header = @studio.header(@raw)
    assert header.is_a?(String)
    assert !header.empty?
  end

  def test_reply_to_address
    reply_to_address = @studio.reply_to_address(@raw)  
    assert reply_to_address.is_a?(String)
    assert reply_to_address.empty?
  end

  def test_reply_to_friendly_name
    reply_to_friendly_name = @studio.reply_to_friendly_name(@raw)  
    assert reply_to_friendly_name.is_a?(String)
    assert reply_to_friendly_name.empty?
  end

  def test_subject
    subject = @studio.subject(@raw)  
    assert subject.is_a?(String)
    assert !subject.empty?
    assert_equal subject.chomp, "failure notice"
  end

  def test_to_address
    to_address = @studio.to_address(@raw)  
    assert to_address.is_a?(String)
    assert !to_address.empty?
    assert_equal to_address, "joebob@joe.net"
  end

  def test_to_friendly_name
    to_friendly_name = @studio.to_friendly_name(@raw)  
    assert to_friendly_name.is_a?(String)
    assert to_friendly_name.empty?
  end

  def test_custom_header
    custom_header = @studio.custom_header(@raw, "X-OriginalArrivalTime".downcase)  
    assert custom_header.is_a?(String)
    assert custom_header.empty?

    date_header = @studio.custom_header(@raw, "Date".downcase)
    assert date_header.is_a?(String)
    assert !date_header.empty?
    assert_equal date_header.chomp, "21 Aug 2000 21:08:21 -0000"
  end

  def test_orig_custom_header
    orig_custom_header = @studio.orig_custom_header(@raw, "X-OriginalArrivalTime".downcase)
    assert orig_custom_header.is_a?(String)
    assert !orig_custom_header.empty?
    assert_equal orig_custom_header.chomp, "21 Aug 2000 21:08:20.0944 (UTC) FILETIME=[EF5F8500:01C00BB3]"
  end
end
