connection: "bigquery_db"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: emails {
  join: users {
    type: left_outer
    sql_on: ${emails.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }
}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: events_count_by_device {}
