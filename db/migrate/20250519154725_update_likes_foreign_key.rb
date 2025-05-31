class UpdateLikesForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :likes, :messages
    add_foreign_key :likes, :messages, on_delete: :cascade
  end
end
