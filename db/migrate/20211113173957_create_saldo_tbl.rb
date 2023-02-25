class CreateSaldoTbl < ActiveRecord::Migration[6.1]
  def change
    create_table :saldos do |t|
      t.decimal :valor, precision: 10, scale: 2
      t.timestamps
    end
  end
end
