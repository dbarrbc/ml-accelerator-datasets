include: "/views/user_churn/*.view"

explore: user_churn {
  label: "User Churn"
}

# explore: customer_satisfaction_predictions {
#   hidden: yes

#   join: customer_satisfaction_predictions__predicted_satisfaction_probs {
#     view_label: "Prediction Probabilities"
#     sql: LEFT JOIN UNNEST(${customer_satisfaction_predictions.predicted_satisfaction_probs}) as aircustomer_satisfaction_predictions__predicted_customer_satisfaction_satisfaction_probs ;;
#     relationship: one_to_many
#   }
# }

# explore: customer_satisfaction_survey {
#   hidden: yes
#   label: "Airline Customer Satisfaction Survey"
# }

# explore: customer_satisfaction_survey_attribute_pcts {
#   hidden: yes
# }
