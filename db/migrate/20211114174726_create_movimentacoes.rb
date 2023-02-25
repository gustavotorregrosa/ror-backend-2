class CreateMovimentacoes < ActiveRecord::Migration[6.1]
  def change
    create_table :movimentacoes do |t|
      t.decimal :valor, precision: 10, scale: 2
      t.string :conta
      t.string :operacao
      t.timestamps
    end
  end
end
