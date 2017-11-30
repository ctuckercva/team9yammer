view: emails {
  sql_table_name: yammer.emails ;;

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension_group: occurred {
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
    sql: ${TABLE}.occurred_at ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_type {
    type: number
    sql: ${TABLE}.user_type ;;
  }

  measure: count {
    type: count
    drill_fields: [users.user_id]
  }
}
