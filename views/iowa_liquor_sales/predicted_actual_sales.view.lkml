view: predicted_actual_sales {
  derived_table: {
    sql:

    WITH topsellingitems AS(
         SELECT
            item_description,
            count(item_description) cnt_transactions
        FROM
            iowa_liquor_sales
        GROUP BY
            item_description
        ORDER BY cnt_transactions DESC
        LIMIT 5 #Top N
    )

    Select
      cast(date as timestamp) as transaction_date,
      item_description,
      sum(bottles_sold) as total_amount_sold ,
      null as forecasted_amount_sold,
      null as prediction_interval_lower_bound,
      null as prediction_interval_upper_bound
    From iowa_liquor_sales
    GROUP BY 1,2
    HAVING item_description IN (SELECT item_description FROM topsellingitems)

    UNION ALL

    Select
      forecast_timestamp as transaction_date,
      item_name as item_description,
      null as total_amount_sold,
      forecast_value as forecasted_amount_sold,
      prediction_interval_lower_bound,
      prediction_interval_upper_bound
    From iowa_liquor_sales_predictor


      ;;
  }

  dimension_group: transaction {
    group_label: "Transaction"
    type: time
    timeframes: [raw,date,month]
    sql: ${TABLE}.transaction_date ;;
  }

  dimension: item_description {
  }

  dimension: total_amount_sold {
    hidden: yes
    type: number
  }

  dimension: forecasted_amount_sold {
    hidden: yes
    type: number
  }

  dimension: prediction_interval_lower_bound {hidden:yes}
  dimension: prediction_interval_upper_bound {hidden:yes}

  measure: total_amount_sold_agg {
    label: "Total Amount Sold"
    type: sum
    sql: ${total_amount_sold} ;;
    value_format_name: decimal_0
  }

  measure: forecasted_amount_sold_agg {
    label: "Forecasted Amount Sold"
    type: sum
    sql: ${forecasted_amount_sold} ;;
    value_format_name: decimal_0
  }

  measure: prediction_interval_lower_bound_agg {
    label: "Prediction Interval Lower Bound"
    type: sum
    sql: ${prediction_interval_lower_bound} ;;
    value_format_name: decimal_0
  }

  measure: prediction_interval_upper_bound_agg {
    label: "Prediction Interval Upper Bound"
    type: sum
    sql: ${prediction_interval_upper_bound} ;;
    value_format_name: decimal_0
  }

  }
