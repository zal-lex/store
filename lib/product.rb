class Product
  attr_reader :title, :cost, :stock_quantity

  def initialize(params)
    @title = params[:title]
    @cost = params[:cost]
    @in_stock = params[:in_stock]
  end
end
