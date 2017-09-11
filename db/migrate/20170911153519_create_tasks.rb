class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :name
      t.references :project, type: :uuid, index: true, foreign_key: {on_delete: :cascade}
      t.boolean :done, default: :false
      t.datetime :forecast
      t.timestamps
    end
  end
end