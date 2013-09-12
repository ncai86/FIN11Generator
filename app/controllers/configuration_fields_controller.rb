class ConfigurationFieldsController < ApplicationController
	before_filter :cached_records, only: [:add_record, :delete_record, :generate_file]

	MERCHANT_ID_CHARACTERS = 15

	def index
		cached_records
		@countries = Country.all
		gon.hiddenFields = ConfigurationField.disabled_fields.collect{|f| 	f.name.parameterize.gsub("company-s-","company-")}
	end

	def add_record
		logger.info "@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		logger.info session[:user]
		logger.info "@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		flash[:error] = nil
		# Gets the constant FIELD that contains the ordered parameters and parameterizes each value
		set_ordered_parameters

		fields = params[:fields]
		@mid = fields[:"merchant-id"]
		@tid = fields[:'terminal-id']
		if valid_mid_tid?(@mid + @tid) == false
			return
		end


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

		@records.nil? ? collated = [] : collated = @records
		# @record_sequence_no = (("0000000") + (collated.size + 1).to_s).last(7)
		# record += @record_sequence_no

		# rewrite collated value to records key after adding to FIN11 record string to collated array
		Rails.cache.write("records_#{session[:user]}", collated << record)
		logger.info Rails.cache.read("records_#{session[:user]}")
		cached_records
		@index = @records.rindex(record)
		@add_record = [collated.size.to_s, record]
	end

	def clear_records
		Rails.cache.write("records_#{session[:user]}", nil)
		Rails.cache.write("MID_TID_#{session[:user]}", nil)
		# redirect_to root_url
	end

	def delete_record
		flash[:error] = nil
		@deletion_index = params[:index].to_i
		mid_tid_records = Rails.cache.read("MID_TID_#{session[:user]}")
		# Rails.cache.write("records_#{ip_identifer}", @records.reject{|r| logger.info r; logger.info "record[#{@records.rindex(r)}== #{@deletion_index}] #{ @records.rindex(r) == @deletion_index}"; @records.index(r) == @deletion_index })
		@records.delete_at @deletion_index
		mid_tid_records.delete_at @deletion_index
		Rails.cache.write "records_#{session[:user]}", @records
		Rails.cache.write "MID_TID_#{session[:user]}", mid_tid_records
		#Set @records for re-rendering of records
		cached_records
	end

	def generate_file
		unless @records.nil?
			filename = "FIN11" + params[:file_date] + params[:file_time] + params[:file_base_currency_code] + params[:file_sequence_no] + params[:file_fcc_acquirer_id] + params[:file_version] + ".DAT"
			content = ""

			f = File.open("tmp/#{filename}", "w+")
			f.binmode
			
			content += "VOL1" + params[:file_date] + params[:file_time] + "\r\n"

			record_count = 0
			@records.each do |record|
				record_sequence_no = (("0000000") + (record_count += 1).to_s).last(7) + ";"
				content += record + record_sequence_no +"\r\n"
				record 
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

	def valid_mid_tid?(mid_tid)
		#Check if midtid already exists in array
		mid_tid_records = Rails.cache.read("MID_TID_#{session[:user]}")
		if mid_tid_records.nil?
			mid_tid_records = [mid_tid]
		else
			if mid_tid_records.include?(mid_tid)
				flash[:error] = "MID TID already exists. Change MID or TID"
				return false
			else
				mid_tid_records << mid_tid
			end
		end
		Rails.cache.write("MID_TID_#{session[:user]}", mid_tid_records, expires_in: 1.hour) if flash[:error].nil?
		return true
	end


	def cached_records
		@records = Rails.cache.read("records_#{session[:user]}") unless Rails.cache.read("records_#{session[:user]}").nil?
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
