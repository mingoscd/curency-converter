#currency converter

# The only condition is: write ALL the tests first. Go full TDD on it. Yeah, all tests first. All of them. Yeah, every single one. Every.
# Single. One. Got it? One more time: every single one. And then, when everything is failing and so on... go implement it.

# Feel free to add support for your country currency! :)
require 'pry'
class TheBanker
  TO_EURO = { usd: 0.77818, gbp: 1.27341, cad: 0.70518, aud: 0.69052 }
  FROM_EURO = { usd: 1.28356, gbp: 0.78478, cad: 1.41613, aud: 1.44651 }

  def self.convert(amount, from_currency, to_currency)
    return nil unless amount.is_a?(Numeric)
    return nil unless from_currency.is_a?(Symbol)
    return nil unless to_currency.is_a?(Symbol)
    
    if to_currency == :euro
      return amount * TO_EURO[from_currency]
    elsif from_currency == :euro
      return amount * FROM_EURO[to_currency]
    else
      amount_aux = self.convert(amount,from_currency,:euro)
      self.convert(amount_aux,:euro,to_currency)
    end
  end
end

describe "TheBanker" do 
  before do
    @bank = TheBanker
  end
  describe "convert" do
    it "should convert currency to euro" do
      expect(@bank.convert(10,:usd,:euro)).to eq(7.7818) 
    end
    it "should convert euro to another currency" do
      expect(@bank.convert(7.7818,:euro,:gbp)).to eq(6.107001004)
    end
    it "should convert a currency to another currency" do
      expect(@bank.convert(10,:usd,:gbp)).to eq(6.107001004)
    end 
  end
end