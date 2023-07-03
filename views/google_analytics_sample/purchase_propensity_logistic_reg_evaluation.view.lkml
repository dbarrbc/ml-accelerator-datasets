# The name of this view in Looker is "Purchase Propensity Logistic Reg Evaluation"
view: purchase_propensity_logistic_reg_evaluation {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ml-accelerator-dbarr.looker_bqml.purchase_propensity_logistic_reg_evaluation`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Accuracy" in Explore.

  dimension: accuracy {
    type: number
    sql: ${TABLE}.accuracy ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_accuracy {
    type: sum
    sql: ${accuracy} ;;
  }

  measure: average_accuracy {
    type: average
    sql: ${accuracy} ;;
  }

  dimension: f1_score {
    type: number
    sql: ${TABLE}.f1_score ;;
  }

  dimension: log_loss {
    type: number
    sql: ${TABLE}.log_loss ;;
  }

  dimension: model_quality {
    type: string
    sql: ${TABLE}.model_quality ;;
  }

  dimension: precision {
    type: number
    sql: ${TABLE}.precision ;;
  }

  dimension: recall {
    type: number
    sql: ${TABLE}.recall ;;
  }

  dimension: roc_auc {
    type: number
    sql: ${TABLE}.roc_auc ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
