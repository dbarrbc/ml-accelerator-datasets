include: "/views/uci_predictive_maintenance/*.view"

explore: predictive_maintenance {}

# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: predict_machine_failure_predictions {
  label: "Machine Failure Predictions"

  join: predict_machine_failure_predictions__predicted_predictive_maintenance_machine_failure_probs {
    view_label: "Prediction Probabilities"
    sql: LEFT JOIN UNNEST(${predict_machine_failure_predictions.predicted_predictive_maintenance_machine_failure_probs}) as predict_machine_failure_predictions__predicted_predictive_maintenance_machine_failure_probs ;;
    relationship: one_to_many
  }
}


explore: predictive_maintenance_demo {
  hidden: yes
}
