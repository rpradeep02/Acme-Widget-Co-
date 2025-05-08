# frozen_string_literal: true

# This class represents a shopping basket with pricing, delivery rules, and optional promotional offers.
class Basket
  def initialize(prices:, delivery_rules:, offers: [])
    @prices         = prices
    @delivery_rules = delivery_rules.sort_by { |r| r[:minimum] }
    @offers         = offers
    @items          = []
  end

  # Adds a product to the basket by its product code.
  #
  # product_code [String, Symbol] The product code to add to the basket.
  # @raise [ArgumentError] Raises an error if the product code is not found in the price list.
  # @return [Basket] Returns the Basket instance to allow method chaining.
  def add(product_code)
    raise ArgumentError, "Unknown product code: #{product_code}" unless @prices.key?(product_code)

    @items << product_code
    self
  end

  # Calculates the total cost of the basket, including discounts and delivery charges.
  #
  # The total includes:
  # - The subtotal of all items in the basket.
  # - Any discounts applied through the associated offers.
  # - Delivery charges based on the delivery rules.
  #
  # @return [Float] The total cost of the basket, rounded to two decimal places.
  def total
    subtotal  = @items.map { |code| @prices[code] }.sum
    discount  = @offers.map { |offer| offer.discount(@items, @prices) }.sum
    after_off = subtotal - discount
    delivery  = calculate_delivery(after_off)

    (after_off + delivery).round(2)
  end

  private

  # Calculates the delivery charge based on the order amount.
  #
  # Delivery charge rules are sorted in ascending order of the minimum amount required.
  # The appropriate rule is identified by finding the highest minimum that the order amount satisfies.
  #
  # Amount [Numeric] The order amount after discounts.
  # @return [Numeric] The delivery charge for the given amount.
  def calculate_delivery(amount)
    rule = @delivery_rules.reverse.find { |r| amount >= r[:minimum] }
    rule[:price]
  end
end
