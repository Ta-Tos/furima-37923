# README

データベース設計
*****

usersテーブル
------------------------------------------------------------------------
|:column               :|:Type                :|:option                :|
|:----------------------|:---------------------|:-----------------------|
|nickname               |string                |null: false             |
|email                  |string                |null: false             |
|encrypted_password     |string                |null: false, format: {with: /\A[a-z0-9]+\z/i}|
|family_name            |string                |null: false, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/}|
|first_name             |string                |null: false, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/}|
|family_kana_name       |string                |null: false, format: {with: /\A[ァ-ヶー]+\z/}|
|first_kana_name        |string                |null: false, format: {with: /\A[ァ-ヶー]+\z/}|
|birthday               |date                  |null: false             |

Association
has_many :items
has_many :comments
has_many :purcharsers


*****
itemsテーブル
------------------------------------------------------------------------
|:column               :|:Type                :|:option                :|
|:----------------------|:---------------------|:-----------------------|
|item_name              |string                |null: false, length: { maximum: 40} |
|item_explain           |text                  |null: false, length: { maximum: 1000} |
|price                  |integer               |null: false, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999             |
|user                   |references            |null: false, foreign_key:true|
|category               |integer               |null: false, numericality: {other_than: 0} |
|item_condition         |integer               |null: false, numericality: {other_than: 0} |
|delivery_charge        |integer               |null: false, numericality: {other_than: 0} |
|prefecture             |integer               |null: false, numericality: {other_than: 0} |
|shipping_days          |integer               |null: false, numericality: {other_than: 0} |

Association  
belongs_to :user  
has_many :commnets  
has_one :purchrser  
has_one :category  
has_one :item_condition  
has_one :delivery_charge  
has_one :shipping_days  
has_one :prefecture  
has_one_attached :image  

*****
purcharsersテーブル
------------------------------------------------------------------------
|:column               :|:Type                :|:option                :|
|:----------------------|:---------------------|:-----------------------|
|postal_code            |string                |null: false, format: {with: /\A[0-9]{3}-[0-9]{4}\z/ |
|prefecture             |integer               |null: false, null: false, numericality: {other_than: 0} |
|municipalities         |string                |null: false             |
|address_number         |string                |null: false             |
|building_name          |string                |                        |
|phone_number           |string                |null: false, length: { minimum: 10} |
|user                   |references            |null: false, foreign_key:true|
|item                   |references            |null: false, foreign_key:true|

Association  
belongs_to :user  
belongs_to :item  

*****
commentsテーブル
------------------------------------------------------------------------
|:column               :|:Type                :|:option                :|
|:----------------------|:---------------------|:-----------------------|
|commnet                |string                |null: false             |
|user                   |references            |null: false, foreign_key:true|
|item                   |references            |null: false, foreign_key:true|

Association  
belongs_to :user  
belongs_to :item  


