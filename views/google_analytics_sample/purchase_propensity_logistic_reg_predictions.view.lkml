# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: purchase_propensity_logistic_reg_predictions {
  hidden: yes

  join: purchase_propensity_logistic_reg_predictions__predicted_will_buy_on_return_visit_probs {
    view_label: "Purchase Propensity Logistic Reg Predictions: Predicted Will Buy On Return Visit Probs"
    sql: LEFT JOIN UNNEST(${purchase_propensity_logistic_reg_predictions.predicted_will_buy_on_return_visit_probs}) as purchase_propensity_logistic_reg_predictions__predicted_will_buy_on_return_visit_probs ;;
    relationship: one_to_many
  }
}

# The name of this view in Looker is "Purchase Propensity Logistic Reg Predictions"
view: purchase_propensity_logistic_reg_predictions {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ml-accelerator-dbarr.looker_bqml.purchase_propensity_logistic_reg_predictions`
    ;;

  dimension: unique_session_id {
    type: string
    sql: ${TABLE}.unique_session_id ;;
  }

  dimension: bounces {
    type: number
    sql: ${TABLE}.bounces ;;
  }

  dimension: channel_grouping {
    type: string
    sql: ${TABLE}.channelGrouping ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: device_category {
    type: string
    sql: ${TABLE}.deviceCategory ;;
  }

  dimension: latest_ecommerce_progress {
    type: number
    sql: ${TABLE}.latest_ecommerce_progress ;;
  }

  dimension: medium {
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: pageviews {
    type: number
    sql: ${TABLE}.pageviews ;;
  }

  dimension: predicted_will_buy_on_return_visit {
    type: number
    sql: ${TABLE}.predicted_will_buy_on_return_visit ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: predicted_will_buy_on_return_visit_probs {
    sql: ${TABLE}.predicted_will_buy_on_return_visit_probs ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: time_on_site {
    type: number
    sql: ${TABLE}.time_on_site ;;
  }


  dimension: will_buy_on_return_visit {
    type: number
    sql: ${TABLE}.will_buy_on_return_visit ;;
  }


  dimension: full_visitor_id {
    type: string
    sql: REGEXP_SUBSTR(${unique_session_id},'[^-]+') ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_bounces {
    type: sum
    sql: ${bounces} ;;
  }

  measure: average_bounces {
    type: average
    sql: ${bounces} ;;
  }

}

# The name of this view in Looker is "Purchase Propensity Logistic Reg Predictions Predicted Will Buy on Return Visit Probs"
view: purchase_propensity_logistic_reg_predictions__predicted_will_buy_on_return_visit_probs {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Label" in Explore.

  dimension: label {
    type: number
    sql: label ;;
    value_format_name: percent_2
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_label {
    type: sum
    sql: ${label} ;;
  }

  measure: average_label {
    type: average
    sql: ${label} ;;
  }

  dimension: prob {
    type: number
    sql: prob ;;
    value_format_name: percent_2
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: purchase_propensity_logistic_reg_predictions__predicted_will_buy_on_return_visit_probs {
    type: string
    hidden: yes
    sql: purchase_propensity_logistic_reg_predictions__predicted_will_buy_on_return_visit_probs ;;
  }
}
