view: another_test_table {
  sql_table_name: looker_test.another_test_table ;;

  dimension: hi {
    type: string
    sql: ${TABLE}.hi ;;
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: []
  }
}
