/**
 * Created by hanhvo on 10/11/17.
 */

package com.a.alda.forecastweather.data.server

import com.a.alda.forecastweather.data.db.ForecastDb
import com.a.alda.forecastweather.domain.datasource.ForecastDataSource
import com.a.alda.forecastweather.domain.model.ForecastList

class ForecastServer(private val dataMapper: ServerDataMapper = ServerDataMapper(),
                     private val forecastDb: ForecastDb = ForecastDb()) : ForecastDataSource {

    override fun requestForecastByZipCode(zipCode: Long, date: Long): ForecastList? {
        val result = ForecastByZipCodeRequest(zipCode).execute()
        val converted = dataMapper.convertToDomain(zipCode, result)
        forecastDb.saveForecast(converted)
        return forecastDb.requestForecastByZipCode(zipCode, date)
    }

    override fun requestDayForecast(id: Long) = throw UnsupportedOperationException()
}