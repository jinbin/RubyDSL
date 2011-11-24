#!/bin/env ruby

fields=["id","company_id","category_id","subject","keywords","gmt_modified","have_image","service_type","summary","description","attr_desc","is_win","owner_member_id","rank_score","is_escrow","gmt_paid_join","certified_type_id","repeat_spam_score"]

files=["Isearch_a+body+kit_cat12345","Isearch_a+body+kit_main124","Isearch_a+body+kit_seo124","Isearch_fleece+fabric+wholesale_main567","Isearch_fleece+fabric+wholesale_seo567","Isearch_pill+box_main3","Isearch_pill+box_seo3","Isearch_wholesale+bike+clothing_main6","Isearch_wholesale+bike+clothing_seo6"]

values=Array.new
files.each do |file|
File.readlines("/home/admin/mlr4.0/ready_data/#{file}").each do |offer|
	offer.split("\x05").each_with_index do |value,i|
		if i < 18
			values[i]=value
		end
	end
	task :xml do
		base
		output "./Ready_XML/#{file}.xml"
		id "#{values[0]}"
		company_id "#{values[1]}"
		category_id "#{values[2]}"
		subject "#{values[3]}"
		keywords "#{values[4]}"
		gmt_modified "#{values[5]}"
		have_image "#{values[6]}"
		service_type "#{values[7]}"
		summary "#{values[8]}"
		description "#{values[9]}"
		attr_desc "#{values[10]}"
		is_win "#{values[11]}"
		owner_member_id "#{values[12]}"
		rank_score "#{values[13]}"
		is_escrow "#{values[14]}"
		gmt_paid_join "#{values[15]}"
		certified_type_id "#{values[16]}"
		repeat_spam_score "#{values[17]}"
	end
end
end


