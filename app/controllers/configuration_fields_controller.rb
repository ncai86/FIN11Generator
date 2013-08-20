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
			end
		end

		#e.g. ;;;0000000;;; 
		# if records key is nil, initialize collated variable.
		# else collated variable set to cached records value

		Rails.cache.read(:records).nil? ? collated = [] : collated = Rails.cache.read(:records)
		# rewrite collated value to records key after adding to FIN11 record string to collated array
		Rails.cache.write(:records, collated << record)


		
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

		redirect_to root_url
	end

private

	def set_ordered_parameters
		@order = []
		FIELDS.each do |f|
			@order << f.parameterize.gsub("company-s-", "company-")
		end
		logger.info 'Order is '
		logger.info @order
		@order
	end

end
