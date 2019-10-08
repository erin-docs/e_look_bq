include: "/orders.view"
include: "/users.view"
include: "/data_tests.lkml"

explore: orders {

  join: users {
    #_each
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
