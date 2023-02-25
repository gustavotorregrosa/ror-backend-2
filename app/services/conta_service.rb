require 'bcrypt'

class ContaService

    def self.create(params)
        conta = Conta.new(params)
        conta.password = BCrypt::Password.create(params[:password])
        conta.agencia = '0001'
        conta.numero_conta = rand(1000000)
        conta.save
        saldo = Saldo.create(id: conta.id, valor: '0')
        conta.id
    end

    def self.muda_senha(params, session)
        return false if params[:senha] == ''
        return false if params[:senha] != params[:confirmacao]
        conta = Conta.find(session[:id])
        conta.password = BCrypt::Password.create(params[:senha])
        conta.save

    end
end