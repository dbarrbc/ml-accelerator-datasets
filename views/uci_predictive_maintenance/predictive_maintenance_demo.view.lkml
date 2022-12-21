include: "/views/uci_predictive_maintenance/predictive_maintenance.view"
view: predictive_maintenance_demo {
  extends: [predictive_maintenance]
measure: avg_air_temperature {
  type: average
  sql: ${air_temperature} ;;
}

measure: avg_tool_wear {
  type: average
  sql: ${tool_wear} ;;
}

  measure: avg_torque {
    type: average
    sql: ${torque} ;;
  }

  measure: avg_process_temperature {
    type: average
    sql: ${process_temperature} ;;
  }

  measure: avg_rotational_speed {
    type: average
    sql: ${rotational_speed} ;;
  }

 }
