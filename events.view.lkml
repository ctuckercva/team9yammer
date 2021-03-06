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
    drill_fields: [event_name, users.user_id]
  }

  measure: login_events {
    type: count
    filters: {
      field: event_name
      value: "login"
    }
  }

  measure: click_any_results_events {
    type: count
    filters: {
      field: event_name
      value: "search_click_result_1, search_click_result_2, search_click_result_3, search_click_result_4, search_click_result_5, search_click_result_6, search_click_result_7, search_click_result_8, search_click_result_9, search_click_result_10"
    }
  }

  measure: send_message_events {
    type: count
    filters: {
      field: event_name
      value: "send_message"
    }
  }

  measure: search_autocomplete_events {
    type: count
    filters: {
      field: event_name
      value: "search_autocomplete"
    }
  }

  measure: view_inbox_events {
    type: count
    filters: {
      field: event_name
      value: "view_inbox"
    }
  }

  measure: like_message_events {
    type: count
    filters: {
      field: event_name
      value: "like_message"
    }
  }

  measure: search_run_events {
    type: count
    filters: {
      field: event_name
      value: "search_run"
    }
  }

  dimension: device_type {
    type:  string
    sql: CASE WHEN device IN ('macbook pro','lenovo thinkpad','macbook air','dell inspiron notebook','asus chromebook',
       'dell inspiron desktop','acer aspire notebook','hp pavilion desktop','acer aspire desktop','mac mini')
              THEN "Computer"
       WHEN device IN ('iphone 5','samsung galaxy s4','nexus 5','iphone 5s','iphone 4s','nokia lumia 635',
           'htc one','samsung galaxy note','amazon fire phone') THEN "Phone"
       WHEN device IN ('ipad air','nexus 7','ipad mini','nexus 10','kindle fire','windows surface',
            'samsumg galaxy tablet') THEN "Tablet" ELSE NULL END ;;
  }
}
