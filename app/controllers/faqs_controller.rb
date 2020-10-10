class FaqsController < ApplicationController
	def new
		@faq = Faq.new
	end
	
	def create
		@faq = Faq.create(faq_params)
		redirect_to faqs_path
	end

	def index
		@faqs= Faq.all.sort_by(&:created_at)
	end

   private
    def faq_params
      params.require(:faq).permit(:question, :description)
    end
end
