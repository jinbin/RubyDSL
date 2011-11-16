#!/bin/env ruby

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'mod'

class MyDSL
	include Mod1
	def xml name=:doc,&block
		if name == :doc
			extend Mod1
		end
		block.call
	end

	def self.load filename
		dsl=new
		dsl.instance_eval(File.read(filename),filename)
		dsl
	end
end

threads=[]    
for file in ARGV 
	threads << Thread.new(file) do |f| 
		if File.file? file
			mydsl=MyDSL.load(file) 
		end
	end
end

threads.each {|thr| thr.join}



