class CreateCryptos < ActiveRecord::Migration[6.1]
  def change
    create_table :cryptos do |t|

      t.timestamps
    end
  end
end
