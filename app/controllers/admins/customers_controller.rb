module Admins
  class CustomersController < ApplicationController
    permits :name, :email

    # GET /customers
    def index
      @customers = Customer.all
    end

    # GET /customers/1
    def show(id)
      @customer = Customer.find(id)
    end

    # GET /customers/new
    def new
      @customer = Customer.new
    end

    # GET /customers/1/edit
    def edit(id)
      @customer = Customer.find(id)
    end

    # POST /customers
    def create(customer)
      @customer = Customer.new(customer)

      if @customer.create_with_stripe
        redirect_to admins_customer_path(@customer), notice: 'Customer was successfully created.'
      else
        render :new
      end
    end

    # PUT /customers/1
    def update(id, customer)
      @customer = Customer.find(id)

      if @customer.update(customer)
        redirect_to admins_customer_path(customer), notice: 'Customer was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /customers/1
    def destroy(id)
      @customer = Customer.find(id)
      @customer.destroy

      redirect_to admins_customers_path, notice: 'Customer was successfully destroyed.'
    end
  end
end
