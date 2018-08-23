class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :title
      t.integer :question_ids
      t.integer :teacher_id
    end 
  end
end
