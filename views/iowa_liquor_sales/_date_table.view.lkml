view: date_table {
  derived_table: {
  sql:
      SELECT
        d AS full_date
      FROM (
        SELECT
          *
        FROM
        UNNEST(GENERATE_DATE_ARRAY('2022-01-01', '2024-01-01', INTERVAL 1 DAY)) AS d );;
    }

  dimension: calendar_date {
    primary_key: yes
    type: date_raw
    sql: cast(${TABLE}.full_date as date) ;;
  }


}
