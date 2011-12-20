class Xml 
	preserved=["__id__","object_id","__send__","respond_to?","instance_eval"]
	instance_methods.each do |m|
		next if preserved.include?(m.to_s)
		undef_method m
	end

	attr_accessor :xml

	@@num=Array.new

	def initialize  
		@xml=Array.new
		@output
	end

	def base filename="#{File.expand_path(File.dirname('__FILE__'),'inXml')}"
		base=IO.read(filename).split("\x01\n")
		@xml=base.dup
	end

	def output filename="outXml"
		@output=filename
	end

	def done
		if @output.nil?
		    puts "No specified output name, default name is output"
		    @output="output"
		end
		if !@@num.include? @output
			File.open(@output,"w")
			@@num << @output
		end
		#at_exit do 
		File.open(@output,"a") do |f|
			f << "<doc>\x01\n"""
			@xml.each do |line|
		    		f << line << "\x01\n"
		  	end
		  	f << "</doc>\x01\n"
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

	attr_accessor :query

	@@list=Array.new

	def initialize
		@query=Array.new
		@output
		@sp="&"
	end
	def base filename="#{File.expand_path(File.dirname('__'),'inQuery')}"
		@query=File.read(filename).split("\n")
		#@query=base.dup
	end

	def add *para
		if para.empty?
			return
		end
		para.each do |item|
			@query.collect! do |line|
				line.chomp("\n")+@sp+item
			end
		end
	end

	def output filename="outQuery"
		@output=filename
	end
	
	def done
		if !@@list.include? @output
			File.open(@output,"w")
			@@list << @output
		end
		File.open(@output,"a") do |f|
			@query.each do |q|
				f << q << "\n"
			end
		end
	end
end





