class RolifyCreateClients < ActiveRecord::Migration
  def change
    create_table(:clients) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_clients, :id => false) do |t|
      t.references :user
      t.references :client
    end

    add_index(:clients, :name)
    add_index(:clients, [ :name, :resource_type, :resource_id ])
    add_index(:users_clients, [ :user_id, :client_id ])
  end
end
