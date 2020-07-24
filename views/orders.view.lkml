include: "/data_tests/data_tests.lkml"


test: user_id_is_unique {
  explore_source: orders_tested {
    column: user_id {}
    column: count {}
    sort: {
      field: count
      desc: yes
    }
    limit: 1
  }
  assert: user_id_is_unique {
    expression: NOT is_null(${orders_tested.user_id}) ;;
    }
}

# repeated test name with same explore_source, see orders_tested view for same test
#
# test: status_is_valid {
#   explore_source: orders_tested {
#     column: status {
#       field: orders_tested.status
#     }
#     sort: {
#       field: status
#       desc: yes     # Sorting of NULL can vary based on database
#     }
#     limit: 1
#   }
#   assert: status_is_not_null {
#     expression: NOT is_null(${orders_tested.status}) ;;
#   }
# }

# repeated test name with different explore_source

test: status_is_valid {
  explore_source: orders {
    column: status {
      field: orders.status
    }
    sort: {
      field: status
      desc: yes     # Sorting of NULL can vary based on database
    }
    limit: 1
  }
  assert: status_is_not_null {
    expression: NOT is_null(${orders.status}) ;;
  }
}




view: orders {
  sql_table_name: looker_test.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: order_amount {
    type: number
    sql: ${TABLE}.order_amount ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    #approximate_threshold: 100000
    drill_fields: [id, users.name, users.id, order_items.count]
  }
}
