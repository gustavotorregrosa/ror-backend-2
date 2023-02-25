class ApplicationController < ActionController::Base
    
    def authorize
        if !session[:conta].present?
            flash[:message] = "Você deve estar logado/a"
            redirect_to '/conta/login'
        end
    end
end
