view: events {
  sql_table_name: yammer.events ;;

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
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
    drill_fields: [event_name, users.user_id]
  }
}
