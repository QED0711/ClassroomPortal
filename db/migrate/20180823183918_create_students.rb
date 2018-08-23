class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :password_digest
      t.integer :teacher_id
      t.integer :test_ids
    end
  end
end
