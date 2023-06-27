# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: simple_churn_model_predictions {
  hidden: yes

  join: simple_churn_model_predictions__predicted_user_churn_churn_indicator_probs {
    view_label: "Simple Churn Model Predictions: Predicted User Churn Churn Indicator Probs"
    sql: LEFT JOIN UNNEST(${simple_churn_model_predictions.predicted_user_churn_churn_indicator_probs}) as simple_churn_model_predictions__predicted_user_churn_churn_indicator_probs ;;
    relationship: one_to_many
  }
}

# The name of this view in Looker is "Simple Churn Model Predictions"
view: simple_churn_model_predictions {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ml-accelerator-dbarr.looker_bqml.simple_churn_model_predictions`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Predicted User Churn Churn Indicator" in Explore.

  dimension: predicted_user_churn_churn_indicator {
    type: string
    sql: ${TABLE}.predicted_user_churn_churn_indicator ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: predicted_user_churn_churn_indicator_probs {
    hidden: yes
    sql: ${TABLE}.predicted_user_churn_churn_indicator_probs ;;
  }

  dimension: user_churn_churn_indicator {
    type: string
    sql: ${TABLE}.user_churn_churn_indicator ;;
  }

  dimension: user_churn_page_view_event_count {
    type: number
    sql: ${TABLE}.user_churn_page_view_event_count ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_user_churn_page_view_event_count {
    type: sum
    sql: ${user_churn_page_view_event_count} ;;
  }

  measure: average_user_churn_page_view_event_count {
    type: average
    sql: ${user_churn_page_view_event_count} ;;
  }

  dimension: user_churn_user_engagement_event_count {
    type: number
    sql: ${TABLE}.user_churn_user_engagement_event_count ;;
  }

  dimension: user_churn_user_id {
    type: string
    sql: ${TABLE}.user_churn_user_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

# The name of this view in Looker is "Simple Churn Model Predictions Predicted User Churn Churn Indicator Probs"
view: simple_churn_model_predictions__predicted_user_churn_churn_indicator_probs {
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Label" in Explore.

  dimension: label {
    type: string
    sql: label ;;
  }

  dimension: prob {
    type: number
    sql: prob ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_prob {
    type: sum
    sql: ${prob} ;;
  }

  measure: average_prob {
    type: average
    sql: ${prob} ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: simple_churn_model_predictions__predicted_user_churn_churn_indicator_probs {
    type: string
    hidden: yes
    sql: simple_churn_model_predictions__predicted_user_churn_churn_indicator_probs ;;
  }
}
