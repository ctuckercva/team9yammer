view: events_count_by_device {
  derived_table: {
    sql: SELECT
          (CASE WHEN device IN ('macbook pro','lenovo thinkpad','macbook air','dell inspiron notebook','asus chromebook',
       'dell inspiron desktop','acer aspire notebook','hp pavilion desktop','acer aspire desktop','mac mini')
              THEN "Computer"
       WHEN device IN ('iphone 5','samsung galaxy s4','nexus 5','iphone 5s','iphone 4s','nokia lumia 635',
           'htc one','samsung galaxy note','amazon fire phone') THEN "Phone"
       WHEN device IN ('ipad air','nexus 7','ipad mini','nexus 10','kindle fire','windows surface',
            'samsumg galaxy tablet') THEN "Tablet" ELSE NULL END) AS Device_type,
       extract(date from occurred_at) as wk_date,
          COUNT(*) AS events_count
      FROM `causal-armor-181501.yammer.events`
      GROUP BY 1,2
      ORDER BY 1,2
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.Device_type ;;
  }

  dimension: wk_date {
    type: date
    sql: ${TABLE}.wk_date ;;
  }

  dimension: events_count {
    type: string
    sql: ${TABLE}.events_count ;;
  }

  set: detail {
    fields: [device_type, wk_date, events_count]
  }
}
