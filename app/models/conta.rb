class Conta < ApplicationRecord
    self.table_name = "contas"
    has_one :saldo, foreign_key: 'id'
end
  