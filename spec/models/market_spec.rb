require 'spec_helper'

describe Market do

  context 'visible market' do
    # it { expect(Market.orig_all.count).to eq(2) }
    it { expect(Market.all.count).to eq(1) }
  end

  context 'markets hash' do
    it "should list all markets info" do
      Market.to_hash.should == {:btcmyr=>{:name=>"BTC/myr", :base_unit=>"btc", :quote_unit=>"myr"}}
    end
  end

  context 'market attributes' do
    subject { Market.find('btcmyr') }

    its(:id)         { should == 'btcmyr' }
    its(:name)       { should == 'BTC/myr' }
    its(:base_unit)  { should == 'btc' }
    its(:quote_unit) { should == 'myr' }
    its(:visible)    { should be_true }
  end

  context 'enumerize' do
    subject { Market.enumerize }

    it { should be_has_key :btcmyr }
    it { should be_has_key :ptsbtc }
  end

  context 'shortcut of global access' do
    subject { Market.find('btcmyr') }

    its(:bids)   { should_not be_nil }
    its(:asks)   { should_not be_nil }
    its(:trades) { should_not be_nil }
    its(:ticker) { should_not be_nil }
  end

end
