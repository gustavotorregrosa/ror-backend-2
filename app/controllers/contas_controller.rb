class ContasController < ApplicationController
    before_action :conta_params, only: [ :salvar ]
    before_action :conta_senhas, only: [ :novasenha ]
    before_action :authorize, :only => [:exibe_saldo, :novasenha]
    
    def apresentacao
        render :inicial
    end

    def novasenha
        if ContaService.muda_senha(conta_senhas, session)
            flash[:message] = "Senha alterada com sucesso"
        else
            flash[:message] = "Senhas inválidas ou não iguais"
        end
        redirect_to '/conta/meusdados'
    end

    def exibe_saldo
        @conta = Conta.includes(:saldo).find(session[:id])
        render :saldo
    end

    def meusdados
        @conta = Conta.includes(:saldo).find(session[:id])
        render :meusdados
    end


    def nova
        render :nova
    end

    def login
        render :login
    end

    def salvar
        conta = ContaService.create(conta_params)
        session[:conta] = conta_params[:nome]
        session[:id] = conta
        redirect_to '/conta/saldo'
    end

    private

    def conta_params
        params.permit(:nome, :email, :password)
    end

    def conta_senhas
        params.permit(:senha, :confirmacao)
    end
end
