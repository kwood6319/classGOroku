class CreateClassgorokuSchema < ActiveRecord::Migration[8.1]
  def up
    execute "CREATE SCHEMA IF NOT EXISTS classgOroku"
  end

  def down
    execute "DROP SCHEMA IF EXISTS classgOroku CASCADE"
  end
end
