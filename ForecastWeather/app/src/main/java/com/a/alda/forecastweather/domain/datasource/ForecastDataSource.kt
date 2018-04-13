/**
 * Created by hanhvo on 10/11/17.
 */

package com.a.alda.forecastweather.domain.datasource

import com.a.alda.forecastweather.domain.model.Forecast
import com.a.alda.forecastweather.domain.model.ForecastList

interface ForecastDataSource {

    fun requestForecastByZipCode(zipCode: Long, date: Long): ForecastList?

    fun requestDayForecast(id: Long): Forecast?

}