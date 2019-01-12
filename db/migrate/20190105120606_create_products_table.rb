class CreateProductsTable < ActiveRecord::Migration[5.2]
	def change
		create_table :products do |t|
			t.string :model
			t.string :brand
			t.integer :ram
			t.integer :external_storage
			t.datetime :year
			t.timestamps
		end
	end
end
