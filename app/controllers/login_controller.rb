class LoginController < ApplicationController

    def attemp_login
        Conta.filter_attributes = []
        conta = Conta.find_by(email: params[:email])
        isAuthed = BCrypt::Password.new(conta.password) ==  params[:password]

        if !isAuthed
            flash[:message] = "Credenciais inválidas"
            redirect_to '/conta/login'
        else
            session[:conta] = conta.nome
            session[:id] = conta.id
            redirect_to '/conta/saldo'
        end
    end

    def logout
        session[:conta] = nil
        session[:id] = nil
        redirect_to '/'
    end

    
end