
test: order_id_is_unique {
  explore_source: orders_tested {
    column: id {}
    column: count {}
    sort: {
      field: count
      desc: yes
    }
    limit: 1
  }
  assert: order_id_is_unique {
    expression: ${orders_tested.count} = 1 ;;
  }
}


test: status_is_valid {
  explore_source: orders_tested {
    column: status {
      field: orders_tested.status
    }
    sort: {
      field: status
      desc: yes     # Sorting of NULL can vary based on database
    }
    limit: 1
  }
  assert: status_is_not_null {
    expression: NOT is_null(${orders_tested.status}) ;;
  }
}


test: status_is_not_null {
  explore_source: orders_tested {
    column: status {}
    sort: {
      field: status
      desc: yes     # Sorting of NULL can vary based on database
    }
    limit: 1
  }
  assert: status_is_not_null {
    expression: NOT is_null(${orders_tested.statis}) ;;
  }
}

view: orders_tested  {
  # sql_table_name: looker_test.orders ;;
  derived_table: {
    sql:
      select case when id > 100 then 0 else id end as id
        , created_at
        , user_id
        , status -- case when mod(id, 100) = 0 then null else status end as status
      from looker_test.orders
      ;;
  }

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
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }
}
