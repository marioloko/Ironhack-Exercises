class Comment < ActiveRecord::Base
	belongs_to :concert, counter_cache: true
	validates :title, :body , presence: true
end
