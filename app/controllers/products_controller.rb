class ProductsController < ApplicationController
	before_action :authenticate_user!
	before_action :load_products

	def show
		filter_products
		download if params["download"].present?
		@products = @products.limit(25)
		@brand = params["brand-equals"]
		@model = params["model-equals"]
		@ram = params["ram_operand"]
		@storage = params["external_storage_operand"]
	end

	private
	def load_products
		@products = Product.all
	end

	def download
		p = Axlsx::Package.new
		wb = p.workbook
		wb.add_worksheet(name: "Your worksheet name") do |sheet|
			sheet.add_row ["Brand", "Model", "RAM", "EXTERNAL STORAGE", "MANUFATURING YEAR"]
			@products.each { |product|
				sheet.add_row [product.brand, product.model, product.ram, product.external_storage, product.year]
			}
		end
		send_data(p.to_stream.read, :type => "application/xlsx", :filename => "products.xlsx")
	end

	def filter_products
		_params = process_params
		_params.each { |key, value|
			value = value.to_s.strip.downcase
			next if value.size == 0
			case key
			when 'brand-equals'
				@products = @products.where("brand like ?", value)
			when 'model-equals'
				@products = @products.where("model like ?", value)
			when 'ram-less_than'
				@products = @products.where("ram < ?", value)
			when 'ram-greater_than'
				@products = @products.where("ram > ?", value)
			when 'ram-equals'
				@products = @products.where("ram = ?", value)
			when 'storage-less_than'
				@products = @products.where("external_storage < ?", value)
			when 'storage-greater_than'
				@products = @products.where("external_storage > ?", value)
			when 'storage-equals'
				@products = @products.where("external_storage = ?", value)
			end
		}
	end

	def process_params
		_params = {}
		_params.merge!({
			params["external_storage_operator"].to_s => params["external_storage_operand"],
			params["ram_operator"].to_s => params["ram_operand"],
			"model-equals" => params["model-equals"].to_s,
			"brand-equals" => params["brand-equals"].to_s
		})
		_params
	end
end
