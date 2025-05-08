class Basket
  def initialize(prices:, delivery_rules:, offers: [])
    @prices         = prices
    @delivery_rules = delivery_rules.sort_by { |r| r[:minimum] }
    @offers         = offers
    @items          = []
  end

  def add(product_code)
    raise ArgumentError, "Unknown product code: #{product_code}" unless @prices.key?(product_code)

    @items << product_code
    self
  end

  def total
    subtotal  = @items.map { |code| @prices[code] }.sum
    discount  = @offers.map { |offer| offer.discount(@items, @prices) }.sum
    after_off = subtotal - discount
    delivery  = calculate_delivery(after_off)

    (after_off + delivery).round(2)
  end

  private

  def calculate_delivery(amount)
    rule = @delivery_rules.reverse.find { |r| amount >= r[:minimum] }
    rule[:price]
  end
end
