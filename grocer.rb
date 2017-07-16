require 'pry'

def consolidate_cart(cart)
	new_hash = {}
	cart.each do |element|
		element.each do |item,contain|
			new_hash[item] = contain unless new_hash[item]
				if new_hash[item][:count] == nil
				new_hash[item][:count] = 1
			else
				new_hash[item][:count] += 1
			end
		end
end
new_hash


end

def apply_coupons(cart, coupons)
	new_h ={}
		cart.each do |item,contain| #cart
			coupons.each do |coupon| #coupon
				if coupon[:item] == item && contain[:count] >= coupon[:num]
					new_h["#{item} W/COUPON"] = {} unless new_h["#{item} W/COUPON"]
					new_h["#{item} W/COUPON"][:clearance] = contain[:clearance]
					new_h["#{item} W/COUPON"][:price] = coupon[:cost]
					new_h["#{item} W/COUPON"][:count] = contain[:count] / coupon[:num]
					contain[:count] = contain[:count] % coupon[:num]
				end
			end
		end
	 cart.merge(new_h)
end

def apply_clearance(cart)
	cart.each do |item,contain|
		if contain[:clearance] == true
			contain[:price] = (contain[:price] * 0.8).round(2)
		end
	end
	cart
end

def checkout(cart, coupons)
	total = 0
	consolidate = consolidate_cart(cart)
	coupon = apply_coupons(consolidate, coupons)
	final = apply_clearance(coupon)
	final.each do |item,contain|
		total += contain[:count] * contain[:price]
	end
	if total > 100
		total = total * 0.9
	end
	total
end

