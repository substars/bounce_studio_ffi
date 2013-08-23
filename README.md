# BounceStudioFfi

A Ruby FFI binding for the (commercial) [BounceStudio API 3.7 for Linux](http://www.boogietools.com/Products/Linux/)

## Requirements

* Ruby 1.9+
* Linux
* BounceStudio API

## Installation

Follow [these installation instructions](http://www.boogietools.com/Products/Linux/BounceStudioAPI/help/files/installation.html) to install the C API library.

Add this line to your application's Gemfile:

    gem 'bounce_studio_ffi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bounce_studio_ffi

## Usage

    BS_LICENSE = "Foobar/1234567890"
    bs = BoogieTools::BounceStudio.new(BS_LICENSE)
    bs.check(raw_message_text)
    
    # all functions documented at http://www.boogietools.com/Products/Linux/BounceStudioAPI/help/help.html
    # are supported, e.g.
    bs.subject(raw_message_text)    
    bs.orig_custom_header(raw_message_text, 'x-subscriber')

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
