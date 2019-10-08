test: user_id_is_not_null {
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
