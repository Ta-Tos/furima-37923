FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@example' }
    password              { 'a11111' }
    password_confirmation { password }
    family_name           { '山田' }
    first_name            { '太郎' }
    family_kana_name      { 'ヤマダ' }
    first_kana_name       { 'タロウ' }
    birthday              { '1980-01-01' }
  end
end
