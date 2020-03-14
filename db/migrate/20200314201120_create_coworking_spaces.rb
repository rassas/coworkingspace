class CreateCoworkingSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :coworking_spaces do |t|
      t.string :name
      t.integer :workstations_limit

      t.timestamps
    end
  end
end
