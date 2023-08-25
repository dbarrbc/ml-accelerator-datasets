# The name of this view in Looker is "Iowa Liquor Sales Predictor"
view: iowa_liquor_sales_predictor {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
 # sql_table_name: `ml-accelerator-dbarr.looker_bqml.iowa_liquor_sales_predictor` ;;
  derived_table: {
    sql:
    SELECT
      *
    FROM
      ML.FORECAST(MODEL looker_bqml.iowa_liquor_sales_model,
                  STRUCT(30 AS horizon,
                         .90 AS confidence_level)
                 )
    ;;
  }



  dimension: composite_key {
    primary_key: yes
    sql: concat(${forecast_timestamp_raw},'-',${item_name}) ;;
  }

  dimension: confidence_interval_lower_bound {
    hidden: yes
    type: number
    sql: ${TABLE}.confidence_interval_lower_bound ;;
  }


  dimension: confidence_interval_upper_bound {
    hidden: yes
    type: number
    sql: ${TABLE}.confidence_interval_upper_bound ;;
  }

  dimension: confidence_level {
    type: number
    sql: ${TABLE}.confidence_level ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: forecast_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.forecast_timestamp ;;
  }

  dimension: forecast_value {
    hidden: yes
    type: number
    sql: ${TABLE}.forecast_value ;;
    value_format_name: decimal_0
  }

  measure: forecast_value_agg {
    label: "Forecasted Amount Sold"
    type: sum
    sql: ${forecast_value} ;;
    value_format_name: decimal_0
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: prediction_interval_lower_bound {
    hidden: yes
    type: number
    sql: ${TABLE}.prediction_interval_lower_bound ;;
    value_format_name: decimal_0
  }

  measure: prediction_interval_lower_bound_agg {
    label: "Prediction Interval Lower Bound Value"
    type: sum
    sql: ${prediction_interval_lower_bound} ;;
    value_format_name: decimal_0
  }

  dimension: prediction_interval_upper_bound {
    hidden: yes
    type: number
    sql: ${TABLE}.prediction_interval_upper_bound ;;
    value_format_name: decimal_0
  }

  measure: prediction_interval_upper_bound_agg {
    label: "Prediction Interval Upper Bound Value"
    type: sum
    sql:  ${prediction_interval_upper_bound} ;;
    value_format_name: decimal_0
  }

  dimension: standard_error {
    hidden: yes
    type: number
    sql: ${TABLE}.standard_error ;;
    value_format_name: decimal_0
  }

  measure: standard_error_agg {
    label: "Standard Error"
    type: average
    sql: ${standard_error} ;;
    value_format_name: decimal_0
  }

  measure: count {
    type: count
    drill_fields: [item_name]
  }
}
