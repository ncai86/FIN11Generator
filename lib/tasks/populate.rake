namespace :populate do
  desc "TODO"
  task :kor_config_field => :environment do
  	ConfigurationName.create name: "KOR"
  	kor = ConfigurationName.where(name: "KOR").first
  	
  	FIELDS.each do |k,v|
  		puts k
  		puts v 
  		kor.configuration_fields.create({name: k, state: v})
  	end

  end

  desc "Korea base currencies"
  task :kor_base_currencies => :environment do
    country = ConfigurationName.where(name: "KOR").first
    country.base_currencies.create currency: "KRW"
    country.base_currencies.create currency: "USD"
  end


  desc "Korea Acquirers"
  task :kor_acquirers => :environment do
    won = BaseCurrency.where(currency: "KRW").first
    won.acquirers.create name: "KEB-KRW", code: "0301"
    won.acquirers.create name: "LOTTE-KRW", code: "0303"
    
    usd = BaseCurrency.where(currency: "USD").first
    usd.acquirers.create name: "KEB-USD", code: "0302"
    usd.acquirers.create name: "LOTTE-USD", code: "0304"
  end

  desc "Korea Currency Merchant Groups"
  task :kor_currency_merchant_groups => :environment do
    keb_krw = Acquirer.where(name: "KEB-KRW").first
    keb_krw.currency_merchant_groups.create([{name: "Group 1", group_id: 1},
                                            {name: "Group 2", group_id: 2},
                                            {name: "Group 3", group_id: 10}
                                            ])

    keb_usd = Acquirer.where(name: "KEB-USD").first
    keb_usd.currency_merchant_groups.create(name: "Group 1", group_id: 1)

    lotte_krw = Acquirer.where(name: "LOTTE-KRW").first
    lotte_krw.currency_merchant_groups.create(name: "Group 1", group_id: 9)

    lotte_usd = Acquirer.where(name: "LOTTE-USD").first
    lotte_usd.currency_merchant_groups.create(name: "Group 1", group_id: 2)
  end

end
