class CreateHooks < ActiveRecord::Migration
  def change
    create_table :hooks do |t|
      t.string :name, limit: 50, null: false
      t.string :backend, limit: 50
      t.text   :config
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
