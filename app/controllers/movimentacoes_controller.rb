class MovimentacoesController < ApplicationController
    before_action :authorize
    before_action :movimentacao_params, only: [ :fazer_deposito ]
    before_action :transferencia_params, only: [ :tranferir ]

    def exibe_deposito
        render :deposito
    end

    def exibe_retirada
        render :retirada
    end
    
    def fazer_deposito
        MovimentacaoService.create_deposito(params, session)
        flash[:message] = "Depósito feito" 
        redirect_to "/"
    end

    def fazer_retirada
        if MovimentacaoService.create_retirada(params, session)
            flash[:message] = "Retirada feita" 
        else
            flash[:message] = "Saldo insuficiente"
        end
        redirect_to "/"
    end

    def tela_tranferencia
        render :transferencia
    end

    def tranferir
        message = MovimentacaoService.transferir(transferencia_params, session)
        flash[:message] = message
        redirect_to "/"
    end

    def extrato
        @itens = MovimentacaoService.get_all(session)
        render :extrato
    end

    private
    
    def movimentacao_params
        params.permit(:valor)
    end

    def transferencia_params
        params.permit(:agencia, :numeroconta, :emaildestino, :valor)
    end

end