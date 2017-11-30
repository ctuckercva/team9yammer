view: users {
  sql_table_name: yammer.users ;;

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: activated {
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
    sql: ${TABLE}.activated_at ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
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

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: count {
    type: count
    drill_fields: [user_id, emails.count, events.count]
  }

  dimension: language_group {
    case: {
      when: {
        sql: ${language} = "english" ;;
        label: "english"
      }
      when: {
        sql: ${language} = "indian" ;;
        label: "indian"
      }
      when: {
        sql: ${language} = "chinese" ;;
        label: "chinese"
      }

      else: "other"
    }
    alpha_sort: yes
  }
}
