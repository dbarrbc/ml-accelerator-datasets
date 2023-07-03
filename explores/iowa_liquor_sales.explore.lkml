include: "/views/iowa_liquor_sales/*"

explore: iowa_liquor_sales_predictor {
}

explore: date_table {
  view_label: "Iowa Liquor Sales vs Prediction"
  join: iowa_liquor_sales {
    sql_on: ${date_table.calendar_date} = ${iowa_liquor_sales.date_date} ;;
    type: left_outer
    relationship: one_to_many
  }
  join: iowa_liquor_sales_predictor {
    sql_on: ${date_table.calendar_date} = ${iowa_liquor_sales_predictor.forecast_timestamp_date} ;;
    type: left_outer
    relationship: one_to_many
  }
}

explore: iowa_liquor_sales {
}

explore: predicted_actual_sales {
  always_filter: {
    filters: [predicted_actual_sales.transaction_date: "last 3 months"]
  }
}
