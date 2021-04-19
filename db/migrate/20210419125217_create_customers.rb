class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers, comment:'顧客' do |t|
      t.string :stripe_id, null: false, comment: 'StripeのID'
      t.string :name, null: false, comment: '顧客名'
      t.string :email, null: false, comment: 'メールアドレス'

      t.timestamps
    end
  end
end
