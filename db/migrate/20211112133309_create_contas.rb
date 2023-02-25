class CreateContas < ActiveRecord::Migration[6.1]
  def change
    create_table :contas do |t|
      t.string :nome
      t.string :email, unique: true
      t.string :agencia
      t.string :numero_conta, unique: true
      t.string :password

      t.timestamps
    end
  end
end
