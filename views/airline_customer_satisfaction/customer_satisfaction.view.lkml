view: customer_satisfaction {
  derived_table: {
    sql:  SELECT *, GENERATE_UUID() as unique_id
          FROM `bqml-accelerator.airline_customer_satisfaction.satisfaction_survey`
    ;;
  }

  dimension: unique_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.unique_id ;;
  }

  dimension: satisfaction {
    label: "Overall Satisfaction"
    type: string
    # sql: ${TABLE}.satisfaction ;;
    sql:  CASE
            WHEN FARM_FINGERPRINT(${unique_id}) <= -4619029773043665920 THEN ${TABLE}.satisfaction
            ELSE NULL
          END
    ;;
  }

  # dimension: gender {
  #   type: string
  #   sql: ${TABLE}.Gender ;;
  # }

  dimension: customer_type {
    type: string
    # sql: ${TABLE}.Customer_Type ;;
    sql: case ${TABLE}.Customer_Type when 'Loyal Customer' then 'Loyalty member'
                    when 'disloyal Customer' then 'Loyalty non-member' end ;;
  }

  # dimension: age {
  #   type: number
  #   sql: ${TABLE}.Age ;;
  # }

  dimension: type_of_travel {
    type: string
    sql: ${TABLE}.Type_of_Travel ;;
  }

  dimension: class {
    type: string
    sql: ${TABLE}.Class ;;
  }

  dimension: flight_distance {
    type: number
    sql: ${TABLE}.Flight_Distance ;;
  }

  dimension: seat_comfort {
    type: number
    sql: ${TABLE}.Seat_comfort ;;
  }

  dimension: departure_arrival_time_convenient {
    type: number
    sql: ${TABLE}.Departure_Arrival_time_convenient ;;
  }

  dimension: food_and_drink {
    type: number
    sql: ${TABLE}.Food_and_drink ;;
  }

  dimension: gate_location {
    type: number
    sql: ${TABLE}.Gate_location ;;
  }

  dimension: inflight_wifi_service {
    type: number
    sql: ${TABLE}.Inflight_wifi_service ;;
  }

  dimension: inflight_entertainment {
    type: number
    sql: ${TABLE}.Inflight_entertainment ;;
  }

  dimension: online_support {
    type: number
    sql: ${TABLE}.Online_support ;;
  }

  dimension: ease_of_online_booking {
    type: number
    sql: ${TABLE}.Ease_of_Online_booking ;;
  }

  dimension: on_board_service {
    type: number
    sql: ${TABLE}.On_board_service ;;
  }

  dimension: leg_room_service {
    type: number
    sql: ${TABLE}.Leg_room_service ;;
  }

  dimension: baggage_handling {
    type: number
    sql: ${TABLE}.Baggage_handling ;;
  }

  dimension: checkin_service {
    type: number
    sql: ${TABLE}.Checkin_service ;;
  }

  dimension: cleanliness {
    type: number
    sql: ${TABLE}.Cleanliness ;;
  }

  dimension: online_boarding {
    type: number
    sql: ${TABLE}.Online_boarding ;;
  }

  dimension: departure_delay_in_minutes {
    type: number
    sql: ${TABLE}.Departure_Delay_in_Minutes ;;
  }

  dimension: arrival_delay_in_minutes {
    type: number
    sql: ${TABLE}.Arrival_Delay_in_Minutes ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_satisfied {
    type: count
    filters: [satisfaction: "satisfied"]
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
      satisfaction,
      customer_type,
      type_of_travel,
      class,
      flight_distance,
      seat_comfort,
      departure_arrival_time_convenient,
      food_and_drink,
      gate_location,
      inflight_wifi_service,
      inflight_entertainment,
      online_support,
      ease_of_online_booking,
      on_board_service,
      leg_room_service,
      baggage_handling,
      checkin_service,
      cleanliness,
      online_boarding,
      departure_delay_in_minutes,
      arrival_delay_in_minutes
    ]
  }
}
