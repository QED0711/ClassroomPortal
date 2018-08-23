class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :questions
      t.string :answer
      t.integer :test_id
    end
  end
end
