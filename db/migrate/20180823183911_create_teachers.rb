class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :student_ids
      t.integer :test_ids
    end
  end
end
