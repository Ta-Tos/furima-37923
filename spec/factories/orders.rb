FactoryBot.define do
  factory :order do
    token          { 'tok_abcdefghijk00000000000000000' }
    postal_code    { '123-4567' }
    prefecture_id  { 2 }
    municipality   { '東京都' }
    address_number { '青山１−１' }
    building_name  { '柳ビル' } 
    phone_number   { '09000000000' }
  end
end
