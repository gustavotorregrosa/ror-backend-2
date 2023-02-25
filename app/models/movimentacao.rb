class Movimentacao < ApplicationRecord
    self.table_name = "movimentacoes"
    has_many :movimentacoes, foreign_key: 'conta'

   
end
  