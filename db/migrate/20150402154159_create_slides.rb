class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.references :slideshowable, polymorphic: true
      t.attachment :picture
      t.integer :order, index: true
      t.string :caption

      t.timestamps null: false
    end
    add_index :slides, :slideshowable_id
    add_index :slides, [:slideshowable_id, :slideshowable_type], name: 'index_slides_on_slideshowable'
    add_index :slides, [:slideshowable_id, :slideshowable_type, :order], name: 'index_slides_on_slideshowable_and_order'
  end
end
