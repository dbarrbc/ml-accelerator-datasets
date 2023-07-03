view: purchase_propensity_prediction_pdt {
  derived_table: {

    # persist_for: "24 hours"

  sql:
    SELECT
      *
      FROM
        ml.PREDICT(MODEL `looker_bqml.purchase_propensity_logistic_reg`,
         (
      WITH all_visitor_stats AS (
      SELECT
        fullvisitorid,
        IF(COUNTIF(totals.transactions > 0 AND totals.newVisits IS NULL) > 0, 1, 0) AS will_buy_on_return_visit
        FROM `data-to-insights.ecommerce.web_analytics`
        GROUP BY fullvisitorid
      )
        SELECT
            CONCAT(fullvisitorid, '-',CAST(visitId AS STRING)) AS unique_session_id,
            # labels
            will_buy_on_return_visit,
            MAX(CAST(h.eCommerceAction.action_type AS INT64)) AS latest_ecommerce_progress,
            # behavior on the site
            IFNULL(totals.bounces, 0) AS bounces,
            IFNULL(totals.timeOnSite, 0) AS time_on_site,
            totals.pageviews,
            # where the visitor came from
            trafficSource.source,
            trafficSource.medium,
            channelGrouping,
            # mobile or desktop
            device.deviceCategory,
            # geographic
            IFNULL(geoNetwork.country, "") AS country
        FROM `data-to-insights.ecommerce.web_analytics`,
           UNNEST(hits) AS h
          JOIN all_visitor_stats USING(fullvisitorid)
        WHERE
          # only predict for new visits
          totals.newVisits = 1
          AND date BETWEEN '20170701' AND '20170801' # test 1 month
        GROUP BY
        unique_session_id,
        will_buy_on_return_visit,
        bounces,
        time_on_site,
        totals.pageviews,
        trafficSource.source,
        trafficSource.medium,
        channelGrouping,
        device.deviceCategory,
        country
      )
      )
      ORDER BY
        predicted_will_buy_on_return_visit DESC ;;

}


    dimension: bounces {
      type: number
      sql: ${TABLE}.bounces ;;
    }

    # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
    # measures for this dimension, but you can also add measures of many different aggregates.
    # Click on the type parameter to see all the options in the Quick Help panel on the right.

    measure: total_bounces {
      type: sum
      sql: ${bounces} ;;
    }

    measure: average_bounces {
      type: average
      sql: ${bounces} ;;
    }

    dimension: channel_grouping {
      type: string
      sql: ${TABLE}.channelGrouping ;;
    }

    dimension: country {
      type: string
      map_layer_name: countries
      sql: ${TABLE}.country ;;
    }

    dimension: device_category {
      type: string
      sql: ${TABLE}.deviceCategory ;;
    }

    dimension: latest_ecommerce_progress {
      type: number
      sql: ${TABLE}.latest_ecommerce_progress ;;
    }

    dimension: medium {
      type: string
      sql: ${TABLE}.medium ;;
    }

    dimension: pageviews {
      type: number
      sql: ${TABLE}.pageviews ;;
    }

    dimension: predicted_will_buy_on_return_visit {
      type: number
      sql: ${TABLE}.predicted_will_buy_on_return_visit ;;
    }

    # This field is hidden, which means it will not show up in Explore.
    # If you want this field to be displayed, remove "hidden: yes".

    dimension: predicted_will_buy_on_return_visit_probs {
      hidden: yes
      sql: ${TABLE}.predicted_will_buy_on_return_visit_probs ;;
    }

    dimension: source {
      type: string
      sql: ${TABLE}.source ;;
    }

    dimension: time_on_site {
      type: number
      sql: ${TABLE}.time_on_site ;;
    }

    dimension: unique_session_id {
      type: string
      sql: ${TABLE}.unique_session_id ;;
    }

    dimension: will_buy_on_return_visit {
      type: number
      sql: ${TABLE}.will_buy_on_return_visit ;;
    }

    measure: count {
      type: count
      drill_fields: []
    }
  }
