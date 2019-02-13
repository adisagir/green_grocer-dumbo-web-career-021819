require 'pry'
def consolidate_cart(cart)
  # code here
  hash_cart = {}
  cart.each do |product|
    product.each do |name, details|
      if !hash_cart[name]
        hash_cart[name] = details
        hash_cart[name][:count] = 1
      elsif hash_cart[name]
        hash_cart[name][:count] += 1
       end
    end
  end
  hash_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    product = coupon[:item]
    next unless cart[product] && cart[product][:count] >= coupon[:num]

    if cart["#{product} W/COUPON"]
      cart["#{product} W/COUPON"][:count] += 1
    else
      cart["#{product} W/COUPON"] = { count: 1, price: coupon[:cost] }
      cart["#{product} W/COUPON"][:clearance] = cart[product][:clearance]
    end
    cart[product][:count] -= coupon[:num]
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |product, details|
    if details[:clearance]
      disc = details[:price] * 0.8
      details[:price] = disc.round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  cart_coupons = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(cart_coupons)
  cart_total = 0

  clearance_cart.each do |product, details|
    cart_total += details[:price] * details[:count]
  end

  if cart_total > 100
    cart_total = (cart_total * 0.9)
  end
  cart_total
end
