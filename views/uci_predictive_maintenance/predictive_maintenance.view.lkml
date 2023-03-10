view: predictive_maintenance {
  sql_table_name: `bqml-accelerator.uci_predictive_maintenance.predictive_maintenance` ;;

  dimension: dataframe {
    type: string
    sql:  CASE
            WHEN FARM_FINGERPRINT(${machine_id}) < 4602018618904989184 THEN 'train'
            ELSE 'predict'
          END
    ;;
  }

  dimension: air_temperature {
    type: number
    sql: ${TABLE}.Air_temperature__K_ ;;
  }

  dimension: failure_type {
    type: string
    sql:  CASE
            WHEN ${dataframe} = 'train' THEN ${TABLE}.Failure_Type
            ELSE NULL
          END
    ;;
  }

  dimension: process_temperature {
    type: number
    sql: ${TABLE}.Process_temperature__K_ ;;
  }

  dimension: machine_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Product_ID ;;
  }

  dimension: rotational_speed {
    type: number
    sql: ${TABLE}.Rotational_speed__rpm_ ;;
  }

  dimension: machine_failure {
    type: string
    sql:  CASE
            WHEN ${dataframe} = 'train' AND ${failure_type} <> 'No Failure' THEN 'Failure'
            WHEN ${dataframe} = 'train' AND ${failure_type} = 'No Failure' THEN 'No Failure'
            ELSE NULL
          END
    ;;
  }

  dimension: tool_wear {
    type: number
    sql: ${TABLE}.Tool_wear__min_ ;;
  }

  dimension: torque {
    type: number
    sql: ${TABLE}.Torque__Nm_ ;;
  }

  dimension: product_quality {
    type: string
    sql:  CASE
            WHEN ${TABLE}.Type = 'L' THEN 'Low'
            WHEN ${TABLE}.Type = 'M' THEN 'Medium'
            WHEN ${TABLE}.Type = 'H' THEN 'High'
          END
    ;;
  }

  measure: count {
    type: count
  }
}
