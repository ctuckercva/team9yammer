view: emails {
  sql_table_name: yammer.emails ;;

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: sent_email {
    type: number
    sql: CASE When ${action} = "sent_weekly_digest" THEN 1
    When ${action} = "sent_reengagement_email" THEN 1
    Else 0
    END;;

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
    sql: CAST(${TABLE}.user_id AS INT64) ;;
  }

  dimension: user_type {
    type: number
    sql: ${TABLE}.user_type ;;
  }

  measure: count {
    type: count
    drill_fields: [users.user_id]
  }

  measure: open_pc {
    type: percent_of_total
    sql: ${TABLE}.open ;;
  }
}
