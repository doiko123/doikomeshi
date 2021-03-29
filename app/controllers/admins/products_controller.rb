module Admins
  class ProductsController < ApplicationController
    def index
    end

    def create(name:)
      @product = Product.create!(name: name)
    end

    def new
    end
  end
end