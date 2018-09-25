view: nested_and_repeated {
  sql_table_name: looker_test.nested_and_repeated ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: doubly_nested_and_repeated__inner_repeated {
    type: string
    sql: ${TABLE}.doubly_nested_and_repeated.inner_repeated ;;
    fanout_on: "doubly_nested_and_repeated.inner_repeated"
  }

  dimension: doubly_nested_and_repeated__other_field {
    type: number
    sql: ${TABLE}.doubly_nested_and_repeated.other_field ;;
    fanout_on: "doubly_nested_and_repeated"
  }

  dimension: nested_field__this_inner_float {
    type: number
    sql: ${TABLE}.nested_field.this_inner_float ;;
  }

  dimension: nested_field__this_inner_string {
    type: string
    sql: ${TABLE}.nested_field.this_inner_string ;;
  }

  dimension: repeated_field {
    type: string
    sql: ${TABLE}.repeated_field ;;
    fanout_on: "repeated_field"
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: [id]
  }
}
