view: purchase_propensity {
  derived_table: {
    sql: SELECT
        fullVisitorId,
        bounces,
        time_on_site,
        will_buy_on_return_visit
      FROM (
            SELECT
              fullVisitorId,
              IFNULL(totals.bounces, 0) AS bounces,
              IFNULL(totals.timeOnSite, 0) AS time_on_site
            FROM
              `data-to-insights.ecommerce.web_analytics`
            WHERE
              totals.newVisits = 1
              AND date BETWEEN '20160801' AND '20170430'
           )
      JOIN (
            SELECT
              fullvisitorid,
              IF (
                  COUNTIF (
                           totals.transactions > 0
                           AND totals.newVisits IS NULL
                          ) > 0,
                  1,
                  0
                 ) AS will_buy_on_return_visit
            FROM
              `bigquery-public-data.google_analytics_sample.*`
            GROUP BY
              fullvisitorid
           )
      USING (fullVisitorId)
      ORDER BY time_on_site DESC
       ;;
  }

  dimension: full_visitor_id {
    type: string
    sql: ${TABLE}.fullVisitorId ;;
  }

  dimension: bounces {
    type: number
    sql: ${TABLE}.bounces ;;
  }

  dimension: time_on_site {
    type: number
    sql: ${TABLE}.time_on_site ;;
  }

  dimension: will_buy_on_return_visit {
    type: number
    sql: ${TABLE}.will_buy_on_return_visit ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [full_visitor_id, bounces, time_on_site, will_buy_on_return_visit]
  }
}
