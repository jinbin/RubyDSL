#!/bin/env ruby

$:.unshift File.expand_path(File.dirname(__FILE__))

require 'mod'

class MyDSL
	def initialize
		@obj
	end
	def task name=:xml,&block
		if name == :xml
			@obj=Xml.new
			@obj.xml.clear
			@obj.xml=@obj.base
			@obj.instance_eval(&block)
			@obj.xml_all << @obj.xml
			@obj.output
		elsif name == :query
			@obj=Query.new
			@obj.query.clear
			@obj.query=@obj.base
			
		end

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



