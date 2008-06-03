class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :title
      t.text :description
      t.string :file_file_name
      t.string :file_content_type
      t.string :file_file_size
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
