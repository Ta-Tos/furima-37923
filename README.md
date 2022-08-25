# README

データベース設計
*****

usersテーブル
------------------------------------------------------------------------
|:column               :|:Type                :|:option                :|
|:----------------------|:---------------------|:-----------------------|
|nickname               |string                |null: false             |
|email                  |string                |null: false, unique: true       |
|encrypted_password     |string                |null: false             |
|family_name            |string                |null: false             |
|first_name             |string                |null: false             |
|family_kana_name       |string                |null: false             |
|first_kana_name        |string                |null: false             |
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
|item_name              |string                |null: false             |
|item_explain           |text                  |null: false             |
|price                  |integer               |null: false             |
|user                   |references            |null: false, foreign_key:true|
|category_id            |integer               |null: false             |
|item_condition_id      |integer               |null: false             |
|delivery_charge_id     |integer               |null: false             |
|prefecture_id          |integer               |null: false             |
|shipping_day_id        |integer               |null: false             |

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
|user                   |references            |null: false, foreign_key:true|
|item                   |references            |null: false, foreign_key:true|

Association  
belongs_to :user  
belongs_to :item  
has_one :shipping_address  

*****
shipping_addressesテーブル
------------------------------------------------------------------------
|:column               :|:Type                :|:option                :|
|:----------------------|:---------------------|:-----------------------|
|postal_code            |string                |null: false             |
|prefecture_id          |integer               |null: false             |
|municipality           |string                |null: false             |
|address_number         |string                |null: false             |
|building_name          |string                |                        |
|phone_number           |string                |null: false             |
|purcharser             |references            |null: false, foreign_key:true|

Association  
belongs_to :purcharser  
has_one :prefecture  

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


