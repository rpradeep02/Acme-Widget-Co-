# frozen_string_literal: true

# This class represents a promotional offer where for every two items of the specified product,
# the second item is offered at half-price.
class BuyOneGetSecondHalfPrice
  def initialize(product_code)
    @product_code = product_code
  end

  # Calculates the discount for the specified product based on the items in the basket.
  #
  # The discount applies to every second item (in pairs) for the given product, at half its price.
  #
  # Items [Array<String, Symbol>] The list of product codes in the basket.
  # Prices [Hash] A hash where keys are product codes (as strings or symbols) and values are their respective prices.
  # @return [Float] The total discount amount for the applicable products.
  def discount(items, prices)
    count = items.count(@product_code)
    pairs = count / 2
    pairs * prices[@product_code] * 0.5
  end
end
