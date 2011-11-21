class Xml 
	preserved=["__id__","object_id","__send__","respond_to?","instance_eval"]
	instance_methods.each do |m|
		next if preserved.include?(m.to_s)
		undef_method m
	end

	attr_accessor :xml,:xml_all

	@@num=Array.new

	def initialize  
		@xml=Array.new
		@xml_all=Array.new
	end

	def base filename="#{File.expand_path(File.dirname('__FILE__'),'inXml')}"
		base=IO.read(filename).split("\x01\n")
		@xml=base.dup
	end

	def output filename="outXml"
		if !@@num.include? filename
			File.open(filename,"w")
			@@num << filename
		end
		#at_exit do 
		File.open(filename,"a") do |f|
			@xml_all.each do |xml|
		  		f << "<doc>\x01\n"
		  		xml.each do |line|
		    			f << line << "\x01\n"
		  		end
		  		f << "</doc>\x01\n"
		  	end
		end
		#end
	end

	def del field
		@xml.each_with_index do |line,num|
			if line.split("=")[0] == field
				@xml.delete(line)
			end
		end
	end

	def method_missing(m,*args)
		exist=0
		@xml.each_with_index do |line,num|
			if line.split("=")[0] == m.to_s
				@xml[num]="#{m}=#{args[0]}"
				exist=1
				break
			end
		end
		if exist == 0
			@xml << "#{m}=#{args[0]}"
			puts "#{m} is a new field, please check."
		end
	end
end

class Query

	attr_accessor :query,:query_all

	@@list=Array.new

	def initialize
		@query=Array.new
		@query_all=Array.new
		@sp="&"
	end
	def base filename="#{File.expand_path(File.dirname('__'),'inQuery')}"
		base=File.read(filename).split("\n")
		@query=base.dup
	end
	
	def output filename="outQuery"
		if !@@list.include? filename
			File.open(filename,"w")
			@@list << filename
		end
		File.open(filename,"a") do |f|
			@query_all.each do |query|
				query.each do |q|
					f << q << "\n"
				end
			end
		end
	end
end





