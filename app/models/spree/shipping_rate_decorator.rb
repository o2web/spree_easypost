Spree::ShippingRate.class_eval do
  def name
    read_attribute(:name)
  end
  
  def shipping_method_code
    name
  end

  def display_cost
    price = display_base_price.to_s

    return price if tax_rate.nil? || tax_amount == 0

    Spree.t tax_rate.included_in_price? ? :including_tax : :excluding_tax,
      scope: "shipping_rates.display_price",
      price: price,
      tax_amount: '',
      tax_rate_name: 'taxes'
  end
end
