class CreateActivationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :activation_tokens do |t|
      t.string :email
      t.string :digest

      t.timestamps
    end
  end
end
