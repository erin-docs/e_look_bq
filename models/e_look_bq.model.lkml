connection: "thelook_bigquery2"

include: "/views/*.view"
include: "/data_tests/data_tests.lkml"


datagroup: e_look_bq_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: e_look_bq_default_datagroup

# NOTE: please see https://looker.com/docs/r/sql/bigquery?version=5.24
# NOTE: for BigQuery specific considerations

explore: all_types {}

explore: another_test_table {}

explore: nested_and_repeated {}

explore: order_items {
  join: orders {
    #_each
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    #_each
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders_tested {
  join: users {
    #_each
    type: left_outer
    sql_on: ${orders_tested.user_id}.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}


# explore: orders {
#   join: users {
#     #_each
#     type: left_outer
#     sql_on: ${orders.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

explore: users {}




# agg_table
explore: +order_items {
  aggregate_table: rollup__orders_created_date {
    query: {
      dimensions: [orders.created_date]
      measures: [average_amount]
    }

    materialization: {
      datagroup_trigger: e_look_bq_default_datagroup
    }
  }
}
