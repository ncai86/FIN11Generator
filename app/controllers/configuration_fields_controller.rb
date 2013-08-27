class ConfigurationFieldsController < ApplicationController


	RECORDS = []
	MERCHANT_ID_CHARACTERS = 15

	def index
		# even = []
		# fields = ConfigurationField.display
		# fields.each_index{ |i| (even << fields[i] if i % 2 == 0) }
		# @left_half = even
		# @right_half = fields - @left_half
		gon.hiddenFields = ConfigurationField.disabled_fields.collect{|f| 	f.name.parameterize.gsub("company-s-","company-")}
		@display_records = Rails.cache.read("records_#{ip_identifer}")
	end

	def add_record
		# Gets the constant FIELD that contains the ordered parameters and parameterizes each value
		set_ordered_parameters

		fields = params[:fields]
		# Initialize record
		record = ""


		# looping ordered list
		# checking if parameters in form is present
		# Storing FIN11 record string

		@order.each do |o|
			if fields.include?(o)
				if o == "merchant-id"
					record += "0" * (MERCHANT_ID_CHARACTERS - fields[o].length) + fields[o] + ";"
				else
					record += (fields[o] + ";")
				end
			else
				record += ";"
			end
		end

		#e.g. ;;;0000000;;; 
		# if records key is nil, initialize collated variable.
		# else collated variable set to cached records value
		Rails.cache.read("records_#{ip_identifer}").nil? ? collated = [] : collated = Rails.cache.read("records_#{ip_identifer}")
		
		# rewrite collated value to records key after adding to FIN11 record string to collated array
		Rails.cache.write("records_#{ip_identifer}", collated << record)
		logger.info Rails.cache.read("records_#{ip_identifer}")

		@add_record = [collated.size.to_s, record]
		
		# order.each do |ordered_param|
		# 	fields

		# fields.each do |k,v|
		# 	k = k.underscore
		# 	logger.info k
		# 	if k == 'merchant_id'
		# 		k = '0' * (MERCHANT_ID_CHARACTERS - v.length) + v
		# 	else
		# 		k = v
		# 	end
		# 	logger.info " value is #{k}"

		# 	logger.info ""
		# end
	end

	def clear_records
		Rails.cache.write("records_#{ip_identifer}", nil)
		# redirect_to root_url
	end

	def generate_file
		filename = "FIN11" + params[:file_date] + params[:file_time] + params[:file_base_currency_code] + "001" + params[:file_fcc_acquirer_id] + params[:file_version] + ".DAT"
		# records = params[:records]
		content = ""
		f = File.open("tmp/#{filename}", "w+")
		f.binmode

		content += "bahhhhhh" + "\r\n"
		content += "bahhhhhhasdasd" + "\r\n"
		f.write content
		f.close

		r = File.open("tmp/#{filename}", "r")
		send_data r.read, filename: filename
		r.close

		File.delete("tmp/#{filename}")

		# f = File.open("tmp/test.txt", "w+")
		# f.binmode
		# f.puts('test!')
		# f.puts "baana!"
		# f.close
		# send_file

		# File.delete("tmp/test.txt")

		# begin
		# 	f = File.open("tmp/test.txt", "w+")
		# 	f.binmode
		# 	f.write('test!')
		# 	f.close
		# ensure
		# 	send_file "tmp/test.txt", :x_sendfile => true
		# end
		# b = File.expand_path("tmp/test.txt")
		# FileUtils.remove_file(b)
	end


	private

	def set_ordered_parameters
		@order = []
		ORDERED_FIELD.each do |f|
			@order << f.parameterize.gsub("company-s-", "company-")
		end
		logger.info 'Order is '
		logger.info @order
		@order
	end

end
