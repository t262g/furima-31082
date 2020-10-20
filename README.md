# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| family_name      | string | null: false |
| first_name       | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | date   | null: false |

### Association

- has_many :items
- has_many :manage_purchases

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| price            | integer    | null: false                    |
| explanation      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| shipping_cost_id | integer    | null: false                    |
| area_id          | integer    | null: false                    |
| delivery_days_id | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association
 
- belongs_to :user
- has_one :manage_purchase

## Manage_purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :purchase

## Purchases テーブル

| Column         | Type    | Options     |
| -------------- | ------- | ----------- |
| postal_code    | integer | null: false |
| prefecture     | string  | null: false |
| city           | string  | null: false |
| address_line_1 | string  | null: false |
| address_line_2 | string  |             |
| phone_number   | integer | null: false |
| card_number    | integer | null: false |
| expiration     | integer | null: false |
| security_code  | integer | null: false |


### Association

- belongs_to :manage_purchase