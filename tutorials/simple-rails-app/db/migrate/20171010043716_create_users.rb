class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :access_token
      t.string :refresh_token

      t.timestamps
    end
  end
end
