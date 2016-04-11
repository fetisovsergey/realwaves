class AddPhotoColumnsToProduct < ActiveRecord::Migration
  def self.up
    add_attachment :products, :photo1
    add_attachment :products, :photo2
    add_attachment :products, :photo3
    add_attachment :products, :photo4
    add_attachment :products, :photo5
  end
  def self.down
    remove_attachment :products, :photo1
    remove_attachment :products, :photo2
    remove_attachment :products, :photo3
    remove_attachment :products, :photo4
    remove_attachment :products, :photo5
  end
end
