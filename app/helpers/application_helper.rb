module ApplicationHelper

	def error_messages_for(object)
		render(:partial => "application/error_messages" , :locals => {:object => object})
	end

	def statusbox(object)
		if object == 1

			return  "box true"
		elsif object == nil
			return "box pending"
		else
			return  "box false"
		end
	end




end
