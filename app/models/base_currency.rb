class BaseCurrency < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :acquirers, :dependent => :destroy
  attr_accessible :currency

  validates :currency, presence: true
end
