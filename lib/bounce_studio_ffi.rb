require "bounce_studio_ffi/version"
require 'ffi'
require 'active_support/core_ext/string/inflections'

module BoogieTools
  class BounceStudio  
    module BounceStudioLib
      extend FFI::Library
      ffi_lib "libBounceStudio32.so"
      attach_function :bsBounceStudio_init, [], :int
      
      STRING_OUTPUT_METHODS = [:header, :subject, :body, :to_address, :to_friendly_name, :reply_to_address, :reply_to_friendly_name, :from_address, :from_friendly_name].freeze    
      STRING_OUTPUT_METHODS.each do |ruby_method_name|
        attach_function :"bsGet#{ruby_method_name.to_s.camelize}", [:string, :pointer], :void
      end
      
      CUSTOM_HEADER_METHODS = [:custom_header, :orig_custom_header].freeze
      CUSTOM_HEADER_METHODS.each do |ruby_method_name|
        attach_function :"bsGet#{ruby_method_name.to_s.camelize}", [:string, :pointer, :string], :void
      end
      
      attach_function :bsBounceCheck, [:string, :pointer, :string, :string], :int  
    end
    
    # gotta call this before we do anything
    BounceStudioLib.bsBounceStudio_init
    
    attr_accessor :license
    def initialize(license='')
      self.license=license
    end

    BounceStudioLib::STRING_OUTPUT_METHODS.each do |ruby_method_name|
      define_method ruby_method_name do |raw_message|
        string_output do |ptr|
          BounceStudioLib.send(:"bsGet#{ruby_method_name.to_s.camelize}", raw_message, ptr)
        end        
      end
    end
    
    BounceStudioLib::CUSTOM_HEADER_METHODS.each do |ruby_method_name|
      define_method ruby_method_name do |raw_message, header_name|
        string_output do |ptr|
          BounceStudioLib.send(:"bsGet#{ruby_method_name.to_s.camelize}", raw_message, ptr, header_name)        
        end      
      end      
    end          
    
    # ignore list is pipe-delimited string of email addresses
    def check(raw_message, ignore_list='')
      code = nil
      string_output do |ptr|
        code = BounceStudioLib.bsBounceCheck(raw_message, ptr, ignore_list, self.license)
      end      
      return code          
    end
      
    protected
  
    def string_output
      FFI::MemoryPointer.new(:pointer) do |ptr|
        yield(ptr)        
        strPtr = ptr.read_pointer
        return strPtr.null? ? nil : strPtr.read_string.force_encoding('UTF-8')
      end
    end     
  end  
  
end