require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:example) do
      @category = Category.create(name: "category")
      @product = Product.new(name: "Comfy chair", price: 10, quantity: 19, category_id: @category.id)
    end

    it "should save a product with all valid fields" do
      @product.save
      expect(@product.save).to eql true
    end

    describe ':name' do
      it "should be present upon new product" do
        @product1 = Product.new(price: 10, quantity: 19, category_id: @category.id)
        @product1.save
        expect(@product1.errors.full_messages.include?("Name can't be blank")).to eql true
      end
    end
    describe ':price' do
      it "should be present upon new product" do
        @product2 = Product.new(name: "Comfy chair", quantity: 19, category_id: @category.id)
        @product2.save
        expect(@product2.errors.full_messages.include?("Price can't be blank")).to eql true
      end
    end
    describe ':quantity' do
      it "should be present upon new product" do
        @product3 = Product.new(name: "Comfy chair", price: 10, category_id: @category.id)
        @product3.save
        expect(@product3.errors.full_messages.include?("Quantity can't be blank")).to eql true
      end
    end
    describe ':category_id' do
      it "should be present upon new product" do
        @product4 = Product.new(name: "Comfy chair", price: 10, quantity: 19)
        @product4.save
        expect(@product4.errors.full_messages.include?("Category can't be blank")).to eql true
      end
    end
  end
end
