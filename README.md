# Acme Widget Co – Checkout Kata

## Overview

Implement a small Ruby checkout system that:

* Knows a product catalogue (code → price)
* Applies delivery charges based on basket value:

  * < \$50 ⇒ \$4.95
  * \$50–<\$90 ⇒ \$2.95
  * ≥ \$90 ⇒ free
* Applies special offers (e.g. “buy one R01, get the second at half price”)
* Exposes:

  * `add(code)` to add an item
  * `total` to get the final price (Float, 2 dp)

## Installation

Clone the repo and install dependencies (if any):

```bash
git clone https://github.com/rpradeep02/Acme-Widget-Co-.git
cd acme-widget-co
```

## Usage

### 1. IRB (Interactive Ruby Shell)

For quick experimentation, you can load the library files directly in IRB:

```bash
cd path/to/acme-widget-co            # your project directory
irb                                   # start IRB
```

Inside IRB, require your code and try out sample baskets:

```ruby
require_relative './basket.rb'
require_relative './buy_one_get_second_half_price.rb'

# Setup:
prices   = { "R01"=>32.95, "G01"=>24.95, "B01"=>7.95 }
delivery = [
  { minimum:  0, price: 4.95 },
  { minimum: 50, price: 2.95 },
  { minimum: 90, price: 0.00 }
]
offers   = [ BuyOneGetSecondHalfPrice.new("R01") ]

checkout = Checkout.new(
  prices: prices,
  delivery_rules: delivery,
  offers: offers
)

# Chain `add` calls and compute total:
puts checkout.add("B01").add("G01").total
# => 37.85
```


## Assumptions

* Offers are independent and can be composed.
* Delivery is calculated *after* all discounts.
* Prices and delivery fees are all in USD.
