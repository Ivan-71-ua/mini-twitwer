class UpdateCommentsForeignKey < ActiveRecord::Migration[7.1]
  def up
    remove_foreign_key :comments, :messages
    add_foreign_key :comments, :messages, on_delete: :cascade
  end

  def down
    remove_foreign_key :comments, :messages
    add_foreign_key :comments, :messages
  end
end
