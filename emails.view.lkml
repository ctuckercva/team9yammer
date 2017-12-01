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
      day_of_week,
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

  measure: count_weekly_digest {
    type: count
    filters: {
      field: action
      value: "sent_weekly_digest"
    }
  }

  measure: count_reengagement {
    type: count
    filters: {
      field: action
      value: "sent_reengagement_email"
    }
  }

  measure: count_opens {
    type: count
    filters: {
      field: action
      value: "email_open"
    }
  }

  measure: count_clickthroughs {
    type: count
    filters: {
      field: action
      value: "email_clickthrough"
    }
  }

  measure: total_emails_sent {
    type: number
    sql:  ${count_weekly_digest}+${count_reengagement} ;;
  }

  measure: open_pc {
    type: number
    sql: safe_divide(${count_opens},(${total_emails_sent}) ;;
  }

  measure: clickthrough_pc_of_open {
    type: number
    sql: safe_divide(${count_clickthroughs},${count_opens}) ;;
  }

  measure: clickthrough_pc_of_sent {
    type:  number
    sql: safe_divide(${count_clickthroughs},${total_emails_sent}) ;;
  }
}
