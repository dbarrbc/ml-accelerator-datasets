# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: iowa_liquor_sales_evaluation {
  hidden: yes
    join: iowa_liquor_sales_evaluation__seasonal_periods {
      view_label: "Iowa Liquor Sales Evaluation: Seasonal Periods"
      sql: LEFT JOIN UNNEST(${iowa_liquor_sales_evaluation.seasonal_periods}) as iowa_liquor_sales_evaluation__seasonal_periods ;;
      relationship: one_to_many
    }
}
# The name of this view in Looker is "Iowa Liquor Sales Evaluation"
view: iowa_liquor_sales_evaluation {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ml-accelerator-dbarr.looker_bqml.iowa_liquor_sales_evaluation` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Aic" in Explore.

  dimension: aic {
    type: number
    sql: ${TABLE}.AIC ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_aic {
    type: sum
    sql: ${aic} ;;  }
  measure: average_aic {
    type: average
    sql: ${aic} ;;  }

  dimension: has_drift {
    type: yesno
    sql: ${TABLE}.has_drift ;;
  }

  dimension: has_holiday_effect {
    type: yesno
    sql: ${TABLE}.has_holiday_effect ;;
  }

  dimension: has_spikes_and_dips {
    type: yesno
    sql: ${TABLE}.has_spikes_and_dips ;;
  }

  dimension: has_step_changes {
    type: yesno
    sql: ${TABLE}.has_step_changes ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: log_likelihood {
    type: number
    sql: ${TABLE}.log_likelihood ;;
  }

  measure: avg_log_likelihood {
    type: average
    sql: ${log_likelihood} ;;
  }

  dimension: modelname {
    type: string
    sql: ${TABLE}.modelname ;;
  }

  dimension: non_seasonal_d {
    type: number
    sql: ${TABLE}.non_seasonal_d ;;
  }

  dimension: non_seasonal_p {
    type: number
    sql: ${TABLE}.non_seasonal_p ;;
  }

  dimension: non_seasonal_q {
    type: number
    sql: ${TABLE}.non_seasonal_q ;;
  }
  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: seasonal_periods {
    hidden: yes
    sql: ${TABLE}.seasonal_periods ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.timestamp ;;
  }

  dimension: variance {
    type: number
    sql: ${TABLE}.variance ;;
  }
  measure: count {
    type: count
    drill_fields: [modelname, item_name]
  }
}

# The name of this view in Looker is "Iowa Liquor Sales Evaluation Seasonal Periods"
view: iowa_liquor_sales_evaluation__seasonal_periods {

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Iowa Liquor Sales Evaluation Seasonal Periods" in Explore.

  dimension: iowa_liquor_sales_evaluation__seasonal_periods {
    type: string
    sql: iowa_liquor_sales_evaluation__seasonal_periods ;;
  }
}
