class ConfigurationFieldsController < ApplicationController
	before_filter :cached_records, only: [:index, :add_record, :generate_file]

	MERCHANT_ID_CHARACTERS = 15

	def index
		# even = []
		# fields = ConfigurationField.display
		# fields.each_index{ |i| (even << fields[i] if i % 2 == 0) }
		# @left_half = even
		# @right_half = fields - @left_half
		@countries = Country.all
		gon.hiddenFields = ConfigurationField.disabled_fields.collect{|f| 	f.name.parameterize.gsub("company-s-","company-")}
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
		# begin
		# 	if @records.nil?
		# 		collated = []
		# 		record_sequence_no = (collated.size + 1).to_s
		# 		record += "0000000" + record_sequence_no
		# 	else
		# 		collated = @records
		# 		record_sequence_no = (collated.size + 1).to_s
		# 		record += ("0000000" + record_sequence_no).last(7)
		# 	end
		# end
		@records.nil? ? collated = [] : collated = @records
		@record_sequence_no = (("0000000") + (collated.size + 1).to_s).last(7)
		record += @record_sequence_no

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
		unless @records.nil?
			filename = "FIN11" + params[:file_date] + params[:file_time] + params[:file_base_currency_code] + params[:file_sequence_no] + params[:file_fcc_acquirer_id] + params[:file_version] + ".DAT"
			content = ""

			f = File.open("tmp/#{filename}", "w+")
			f.binmode
			
			content += "VOL1" + params[:file_date] + params[:file_time] + "\r\n"
			@records.each do |record|
				content += record + "\r\n"
			end
			content += "UTL1" + ("0000000" + @records.size.to_s).last(7)
			f.write content
			f.close
			#### closing written file

			#### opening file to send data
			r = File.open("tmp/#{filename}", "r")
			send_data r.read, filename: filename
			r.close

			# Deletion of tmp filename
			File.delete("tmp/#{filename}")
		else
			flash[:error] = "no records"
			redirect_to root_url
		end
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

	def cached_records
		@records = Rails.cache.read("records_#{ip_identifer}") unless Rails.cache.read("records_#{ip_identifer}").nil?
	end


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
