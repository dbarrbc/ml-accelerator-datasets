view: user_churn {
  sql_table_name: `bqmlpublic.demo_ga4churnprediction.training_data`;;

# user ID
# {
  dimension: user_pseudo_id {
    primary_key: yes
    label: "Unique User pseudo ID"
    type: string
    sql: ${TABLE}.user_pseudo_id ;;
  }
# }

# Label
# {
  dimension: churned {
    label: "Churn Indicator Label"
    type: string
    sql: cast(${TABLE}.churned as string) ;;
  }
# }

# Demographic features
# {
  dimension: country {
    description: "Country information derived from geo.country"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: language {
    description: "Device Language information from device.language"
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: operating_system {
    description: "Device OS information from device.operating_system"
    type: string
    sql: ${TABLE}.operating_system ;;
  }
# }

# Behavioral features
# {
  dimension: cnt_add_payment_info {
    description: "Count of additional payment information captured"
    type: number
    sql: ${TABLE}.cnt_add_payment_info ;;
  }

  dimension: cnt_add_shipping_info {
    description: "Count of additional shipping information captured"
    type: number
    sql: ${TABLE}.cnt_add_shipping_info ;;
  }

  dimension: cnt_add_to_cart {
    description: "Count of sessions when user reached add to cart"
    type: number
    sql: ${TABLE}.cnt_add_to_cart ;;
  }

  dimension: cnt_begin_checkout {
    description: "Count of sessions when user started checkout"
    type: number
    sql: ${TABLE}.cnt_begin_checkout ;;
  }

  dimension: cnt_page_view {
    description: "Count of page views"
    type: number
    sql: ${TABLE}.cnt_page_view ;;
  }

  dimension: cnt_purchase {
    description: "Count of purchase"
    type: number
    sql: ${TABLE}.cnt_purchase ;;
  }

  dimension: cnt_select_promotion {
    description: "Count of selected promotions"
    type: number
    sql: ${TABLE}.cnt_select_promotion ;;
  }

  dimension: cnt_user_engagement {
    type: number
    sql: ${TABLE}.cnt_user_engagement ;;
  }

  dimension: cnt_view_item {
    type: number
    sql: ${TABLE}.cnt_view_item ;;
  }

  dimension: cnt_view_promotion {
    type: number
    sql: ${TABLE}.cnt_view_promotion ;;
  }
# }

# user_first_engagement time related features
# {
  dimension: dayofweek {
    description: "Day of the week of user's first engagement"
    type: number
    sql: ${TABLE}.dayofweek ;;
  }

  dimension: julianday {
    description: "Day of the year of user's first engagement"
    type: number
    sql: ${TABLE}.julianday ;;
  }

  dimension: month {
    description: "Month of user's first engagement"
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension_group: user_first_engagement {
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
    sql: ${TABLE}.user_first_engagement ;;
  }
# }


  measure: count {
    type: count
    drill_fields: []
  }
}
