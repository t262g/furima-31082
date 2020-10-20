# テーブル設計

## users テーブル

| Column           | Type    | Options     |
| ---------------- | ------- | ----------- |
| nickname         | string  | null: false |
| email            | string  | null: false |
| password         | string  | null: false |
| family_name      | string  | null: false |
| first_name       | string  | null: false |
| family_name_kana | string  | null: false |
| first_name_kana  | string  | null: false |
| birthday         | integer | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| price         | integer    | null: false                    |
| explanation   | text       | null: false                    |
| category      | string     | null: false                    |
| condition     | string     | null: false                    |
| shipping_cost | boolean    | null: false                    |
| area          | string     | null: false                    |
| sold_out      | boolean    | null: false                    |
| delivery_days | string     | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association
 
 - belongs_to :user
 - has_one :purchase

 ## Purchases テーブル

 | Column         | Type       | Options                        |
 | -------------- | ---------- | ------------------------------ |
 | postal_code    | integer    | null: false                    |
 | prefecture     | string     | null: false                    |
 | city           | string     | null: false                    |
 | address_line_1 | string     | null: false                    |
 | address_line_2 | string     |                                |
 | phone_number   | integer    | null: false                    |
 | card_number    | integer    | null: false                    |
 | expiration     | integer    | null: false                    |
 | security_code  | integer    | null: false                    |
 | user           | references | null: false, foreign_key: true |
 | item           | references | null: false, foreign_key: true |

 ### Association

 - belongs_to :user
 - belongs_to :item