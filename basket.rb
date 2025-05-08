class Basket
  def initialize(prices:)
    @prices         = prices
    @items          = []
  end

  def add(product_code)
    raise ArgumentError, "Unknown product code: #{product_code}" unless @prices.key?(product_code)

    @items << product_code
  end
end
