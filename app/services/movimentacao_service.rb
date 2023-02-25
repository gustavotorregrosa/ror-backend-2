class MovimentacaoService

    def self.create_deposito(params, session)
        Movimentacao.create(valor: params[:valor], conta: session[:id], operacao: 'deposito')
        saldo = Saldo.find(session[:id])
        saldo.valor = saldo.valor + params[:valor].to_d
        saldo.save
    end

    def self.create_retirada(params, session)
        saldo = Saldo.find(session[:id])
        saldo.valor = saldo.valor - params[:valor].to_d
        return false if saldo.valor < 0
        Movimentacao.create(valor: params[:valor], conta: session[:id], operacao: 'retirada')
        saldo.save
        true
    end

    def self.transferir(params, session)

        saldo_origem = Saldo.find(session[:id])
        novo_saldo_origem = saldo_origem.valor - params[:valor].to_d - get_taxa
        return 'Não há saldo suficiente' if novo_saldo_origem < 0

        conta_destino = Conta.find_by(email: params[:emaildestino], agencia: params[:agencia], numero_conta: params[:numeroconta])
        return 'Conta destino não existente' if !conta_destino
        
        Movimentacao.create(valor: params[:valor].to_d + get_taxa.to_d, conta: session[:id], operacao: 'retirada')
        saldo_origem.valor = novo_saldo_origem
        saldo_origem.save

        Movimentacao.create(valor: params[:valor].to_d, conta: conta_destino.id, operacao: 'deposito')
        saldo_destino = Saldo.find(conta_destino.id)
        saldo_destino.valor = saldo_destino.valor + params[:valor].to_d
        saldo_destino.save

        return 'Transferencia feita com sucesso'
        
    end

    def self.get_all(session)
        Movimentacao.where(conta: session[:id])
    end

    private
    
    def self.get_taxa
        taxa = 5
    end
end