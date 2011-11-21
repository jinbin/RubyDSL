class Xml 
	preserved=["__id__","object_id","__send__","respond_to?","instance_eval"]
	instance_methods.each do |m|
		next if preserved.include?(m.to_s)
		undef_method m
	end

	attr_accessor :base,:xml,:xml_all

	@@num=0

	def initialize  
		@base=Array.new
		@xml=Array.new
		@xml_all=Array.new
	end

	def base filename="#{File.expand_path(File.dirname('__FILE__'),'inXml')}"
		@base=IO.read(filename).split("\x01\n")
		@xml=@base.dup
	end

	def output filename="outXml"
		if @@num == 0
			File.open(filename,"w")
			@@num = @@num + 1
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
		#@xml_all << @xml
	end
end

class Query
	def initialize
		@query=Array.new
		@sp="&"
	end
	def base filename="#{File.expand_path(File.dirname('__'))}"
		puts "Unfinished"
	end
	
	def output filename=
		puts "Unfinished" 
	end
end





