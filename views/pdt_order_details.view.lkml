view: pdt_order_details {
 derived_table: {
     sql: select
oit.id order_item_id,
ord.status order_status,
ord.created_at as order_date,
usr.id as user_id,
usr.gender,
usr.age,
case when usr.age < 30 then true else false end as is_young,
oit.sale_price,
count(oit.id) as order_items_count,
inv.cost,
count(inv.id) as inventory_items_count,
prd.brand,
prd.item_name as product_name,
prd.retail_price

from demo_db.orders ord
left join demo_db.users usr
    on ord.user_id = usr.id
left join demo_db.order_items oit
    on ord.id = oit.order_id
left join demo_db.inventory_items inv
    on oit.inventory_item_id = inv.id
left join demo_db.products prd
    on inv.product_id = prd.id

where extract(year from ord.created_at) = 2016

group by
oit.id,
ord.status,
ord.created_at,
usr.id,
usr.gender,
usr.age,
case when usr.age < 30 then true else false end,
oit.sale_price,
inv.cost,
prd.brand,
prd.item_name,
prd.retail_price
       ;;

  datagroup_trigger: cmu_datagroup
  indexes: ["order_item_id"]
}
#
#   # Define your dimensions and measures here, like this:
   dimension: order_item_id {
#     description: "Unique ID for each user that has ordered"
     type: string
    primary_key: yes
     sql: ${TABLE}.order_item_id ;;
   }
#
   dimension: order_status {
     type: string
     sql: ${TABLE}.order_status ;;
   }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: is_young {
    type: yesno
    sql: ${TABLE}.is_young ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

#
   dimension_group: order_date {
#     description: "The date when each user last ordered"
     type: time
     timeframes: [date, week, month, year]
     sql: ${TABLE}.order_date ;;
   }
#
   measure: order_items_count {
#     description: "Use this for counting lifetime orders across many users"
     type: count
  #   sql: ${order_items_count} ;;
   }

  measure: inventory_items_count {
#     description: "Use this for counting lifetime orders across many users"
    type: count
   # sql: ${inventory_items_count} ;;
  }

 }
