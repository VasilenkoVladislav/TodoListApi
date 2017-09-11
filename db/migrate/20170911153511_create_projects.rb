class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.references :user, type: :uuid, index: true, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end