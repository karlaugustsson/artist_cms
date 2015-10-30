class PublicController < ApplicationController
	layout 'standard'

	before_action :redirect_if_logged_in_artist
	def index
	end


	private

end
