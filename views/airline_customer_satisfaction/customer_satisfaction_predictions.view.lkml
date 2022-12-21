view: customer_satisfaction_predictions {
  sql_table_name: `bqml-accelerator.looker_bqml.airline_customer_satisfaction_predictions` ;;

  dimension: arrival_delay_in_minutes {
    type: number
    sql: ${TABLE}.customer_satisfaction_arrival_delay_in_minutes ;;
  }

  dimension: baggage_handling {
    type: number
    sql: ${TABLE}.customer_satisfaction_baggage_handling ;;
  }

  dimension: checkin_service {
    type: number
    sql: ${TABLE}.customer_satisfaction_checkin_service ;;
  }

  dimension: cleanliness {
    type: number
    sql: ${TABLE}.customer_satisfaction_cleanliness ;;
  }

  dimension: customer_type {
    type: string
    sql: ${TABLE}.customer_satisfaction_customer_type ;;
  }

  dimension: departure_arrival_time_convenient {
    type: number
    sql: ${TABLE}.customer_satisfaction_departure_arrival_time_convenient ;;
  }

  dimension: ease_of_online_booking {
    type: number
    sql: ${TABLE}.customer_satisfaction_ease_of_online_booking ;;
  }

  dimension: flight_distance {
    type: number
    sql: ${TABLE}.customer_satisfaction_flight_distance ;;
  }

  dimension: inflight_entertainment {
    type: number
    sql: ${TABLE}.customer_satisfaction_inflight_entertainment ;;
  }

  dimension: leg_room_service {
    type: number
    sql: ${TABLE}.customer_satisfaction_leg_room_service ;;
  }

  dimension: on_board_service {
    type: number
    sql: ${TABLE}.customer_satisfaction_on_board_service ;;
  }

  dimension: online_support {
    type: number
    sql: ${TABLE}.customer_satisfaction_online_support ;;
  }

  dimension: satisfaction {
    type: string
    sql: ${TABLE}.customer_satisfaction_satisfaction ;;
  }

  dimension: seat_comfort {
    type: number
    sql: ${TABLE}.customer_satisfaction_seat_comfort ;;
  }

  dimension: type_of_travel {
    type: string
    sql: ${TABLE}.customer_satisfaction_type_of_travel ;;
  }

  dimension: unique_id {
    label: "Unique ID"
    primary_key: yes
    type: string
    sql: ${TABLE}.customer_satisfaction_unique_id ;;
  }

  dimension: predicted_satisfaction {
    label: "Overall Satisfaction Prediction"
    type: string
    sql: ${TABLE}.predicted_customer_satisfaction_satisfaction ;;
  }

  dimension: predicted_satisfaction_probs {
    hidden: yes
    sql: ${TABLE}.predicted_customer_satisfaction_satisfaction_probs ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_satisfied {
    type: count
    filters: [predicted_satisfaction: "satisfied"]
    drill_fields: [detail*]
  }

  measure: percent_satisfied {
    type: number
    sql: ${count_satisfied}/${count} ;;
    value_format_name: percent_1
  }

  measure: average_arrival_delay {
    description: "Average arrival delay in minutes"
    type: average
    sql: ${arrival_delay_in_minutes} ;;
    value_format_name: decimal_0
  }

  measure: average_flight_distance {
    type: average
    sql: ${flight_distance} ;;
    value_format_name: decimal_0
  }

  set: detail {
    fields: [
      unique_id,
      customer_type,
      type_of_travel,
      flight_distance,
      arrival_delay_in_minutes,
      predicted_satisfaction
    ]
  }
}


# The name of this view in Looker is "Airline Customer Satisfaction Predictions Predicted Customer Satisfaction Satisfaction Probs"
view: customer_satisfaction_predictions__predicted_satisfaction_probs {

  dimension: customer_satisfaction_predictions__predicted_satisfaction_probs {
    type: string
    hidden: yes
    sql: airline_customer_satisfaction_predictions__predicted_customer_satisfaction_satisfaction_probs ;;
  }

  dimension: label {
    type: string
    sql: label ;;
  }

  dimension: probability {
    type: number
    sql: prob ;;
  }

  measure: average_probability {
    type: average
    sql: ${probability} ;;
  }
}
