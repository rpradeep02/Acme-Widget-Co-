class BuyOneGetSecondHalfPrice
  def initialize(product_code)
    @product_code = product_code
  end

  def discount(items, prices)
    count = items.count(@product_code)
    pairs = count / 2
    pairs * prices[@product_code] * 0.5
  end
end
