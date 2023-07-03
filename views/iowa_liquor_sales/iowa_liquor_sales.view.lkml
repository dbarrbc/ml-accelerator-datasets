# The name of this view in Looker is "Iowa Liquor Sales"
view: iowa_liquor_sales {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ml-accelerator-dbarr.looker_bqml.iowa_liquor_sales` ;;


  dimension: invoice_and_item_number {
    primary_key: yes
    type: string
    description: "Concatenated invoice and line number associated with the liquor order. This provides a unique identifier for the individual liquor products included in the store order."
    sql: ${TABLE}.invoice_and_item_number ;;
  }

  dimension: address {
    type: string
    description: "Address of store who ordered the liquor."
    sql: ${TABLE}.address ;;
  }

  dimension: bottle_volume_ml {
    type: number
    description: "Volume of each liquor bottle ordered in milliliters."
    sql: ${TABLE}.bottle_volume_ml ;;
  }

  dimension: bottles_sold {
    type: number
    description: "The number of bottles of liquor ordered by the store"
    sql: ${TABLE}.bottles_sold ;;
  }

  dimension: category {
    type: string
    description: "Category code associated with the liquor ordered"
    sql: ${TABLE}.category ;;
  }

  dimension: category_name {
    type: string
    description: "Category of the liquor ordered."
    sql: ${TABLE}.category_name ;;
  }

  dimension: city {
    type: string
    description: "City where the store who ordered the liquor is located"
    sql: ${TABLE}.city ;;
  }

  dimension: county {
    type: string
    description: "County where the store who ordered the liquor is located"
    sql: ${TABLE}.county ;;
  }

  dimension: county_number {
    type: string
    description: "Iowa county number for the county where store who ordered the liquor is located"
    sql: ${TABLE}.county_number ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    description: "Date of order"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }


  dimension: item_description {
    type: string
    description: "Description of the individual liquor product ordered."
    sql: ${TABLE}.item_description ;;
  }

  dimension: item_number {
    type: string
    description: "Item number for the individual liquor product ordered."
    sql: ${TABLE}.item_number ;;
  }

  dimension: pack {
    type: number
    description: "The number of bottles in a case for the liquor ordered"
    sql: ${TABLE}.pack ;;
  }

  dimension: sale_dollars {
    type: number
    description: "Total cost of liquor order (number of bottles multiplied by the state bottle retail)"
    sql: ${TABLE}.sale_dollars ;;
  }

  dimension: state_bottle_cost {
    type: number
    description: "The amount that Alcoholic Beverages Division paid for each bottle of liquor ordered"
    sql: ${TABLE}.state_bottle_cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_state_bottle_cost {
    type: sum
    sql: ${state_bottle_cost} ;;  }
  measure: average_state_bottle_cost {
    type: average
    sql: ${state_bottle_cost} ;;  }

  dimension: state_bottle_retail {
    type: number
    description: "The amount the store paid for each bottle of liquor ordered"
    sql: ${TABLE}.state_bottle_retail ;;
  }

  dimension: store_location {
    type: string
    description: "Location of store who ordered the liquor. The Address, City, State and Zip Code are geocoded to provide geographic coordinates. Accuracy of geocoding is dependent on how well the address is interpreted and the completeness of the reference data used."
    sql: ${TABLE}.store_location ;;
  }

  dimension: store_name {
    type: string
    description: "Name of store who ordered the liquor."
    sql: ${TABLE}.store_name ;;
  }

  dimension: store_number {
    type: string
    description: "Unique number assigned to the store who ordered the liquor."
    sql: ${TABLE}.store_number ;;
  }

  dimension: vendor_name {
    type: string
    description: "The vendor name of the company for the brand of liquor ordered"
    sql: ${TABLE}.vendor_name ;;
  }

  dimension: vendor_number {
    type: string
    description: "The vendor number of the company for the brand of liquor ordered"
    sql: ${TABLE}.vendor_number ;;
  }

  dimension: volume_sold_gallons {
    type: number
    description: "Total volume of liquor ordered in gallons. (i.e. (Bottle Volume (ml) x Bottles Sold)/3785.411784)\""
    sql: ${TABLE}.volume_sold_gallons ;;
  }

  dimension: volume_sold_liters {
    type: number
    description: "Total volume of liquor ordered in liters. (i.e. (Bottle Volume (ml) x Bottles Sold)/1,000)\""
    sql: ${TABLE}.volume_sold_liters ;;
  }

  dimension: zip_code {
    type: zipcode
    description: "Zip code where the store who ordered the liquor is located"
    sql: ${TABLE}.zip_code ;;
  }
  measure: count {
    type: count
    drill_fields: [category_name, vendor_name, store_name]
  }

  measure: total_amount_sold {
    type: sum
    sql: ${bottles_sold} ;;
  }
}
