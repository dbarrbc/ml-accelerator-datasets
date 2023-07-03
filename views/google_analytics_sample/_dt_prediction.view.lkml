view: _dt_prediction {
    derived_table: {
      explore_source: purchase_propensity_logistic_reg_predictions {
        column: bounces {}
        column: channel_grouping {}
        column: country {}
        column: device_category {}
        column: full_visitor_id {}
        column: latest_ecommerce_progress {}
        column: medium {}
        column: pageviews {}
        column: predicted_will_buy_on_return_visit {}
        column: will_buy_on_return_visit {}
        column: source {}
        column: time_on_site {}
        column: unique_session_id {}
        column: label { field: purchase_propensity_logistic_reg_predictions__predicted_will_buy_on_return_visit_probs.label }
        column: prob { field: purchase_propensity_logistic_reg_predictions__predicted_will_buy_on_return_visit_probs.prob }
      }
    }


    dimension: composite_key {
      primary_key: yes
      sql: concat(${unique_session_id},'-',cast(${prob} as string) ;;
    }

    dimension: bounces {
      description: ""
      type: number
    }
    dimension: channel_grouping {
      description: ""
    }
    dimension: country {
      description: ""
    }
    dimension: device_category {
      description: ""
    }
    dimension: full_visitor_id {
      description: ""
    }
    dimension: latest_ecommerce_progress {
      description: ""
      type: number
    }
    dimension: medium {
      description: ""
    }
    dimension: pageviews {
      description: ""
      type: number
    }
    dimension: predicted_will_buy_on_return_visit {
      description: ""
      type: number
    }
    dimension: will_buy_on_return_visit {
      description: ""
      type: number
    }
    dimension: source {
      description: ""
    }
    dimension: time_on_site {
      description: ""
      type: number
    }
    dimension: unique_session_id {
      description: ""
    }
    dimension: label {
      label: "Purchase Propensity Logistic Reg Predictions: Predicted Will Buy On Return Visit Probs Label"
      description: ""
      type: number
    }
    dimension: prob {
      label: "Purchase Propensity Logistic Reg Predictions: Predicted Will Buy On Return Visit Probs Prob"
      description: ""
      type: number
      value_format_name: percent_4
    }

    dimension: is_true_prediction_buy_on_return_visit {
      type: yesno
      sql: ${predicted_will_buy_on_return_visit} = 1 and ${will_buy_on_return_visit} = 1 ;;
    }

    measure: predicted_return_visit_purchases {
      type: sum
      sql: ${predicted_will_buy_on_return_visit} ;;
    }

  measure: actual_return_visit_purchases {
    type: sum
    sql: ${will_buy_on_return_visit} ;;
  }

}
