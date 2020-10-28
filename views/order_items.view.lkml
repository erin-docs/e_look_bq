view: order_items {

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: sku_num {
    type: number
    sql: ${TABLE}.sku_num ;;
  }

  measure: count {
    type: count
    #approximate_threshold: 100000
    drill_fields: [id, orders.id]
  }


  dimension: amount_dimension {
    sql: (${TABLE}.amount) ;;
  }

  measure: average_amount {
    type: average
    sql: ${TABLE}.amount ;;
  }

  measure: average_amount_from_dimension {
    type: average
    sql: ${amount_dimension} ;;
  }


}
