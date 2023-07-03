# The name of this view in Looker is "Purchase Propensity Logistic Reg Global Explain"
view: purchase_propensity_logistic_reg_global_explain {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ml-accelerator-dbarr.looker_bqml.purchase_propensity_logistic_reg_global_explain`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Attribution" in Explore.

  dimension: attribution {
    type: number
    sql: ${TABLE}.attribution ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_attribution {
    type: sum
    sql: ${attribution} ;;
  }

  measure: average_attribution {
    type: average
    sql: ${attribution} ;;
  }

  dimension: feature {
    type: string
    sql: ${TABLE}.feature ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
