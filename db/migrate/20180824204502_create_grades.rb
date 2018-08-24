class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.float :score
      t.integer :test_id
      t.integer :student_id
    end
  end
end
