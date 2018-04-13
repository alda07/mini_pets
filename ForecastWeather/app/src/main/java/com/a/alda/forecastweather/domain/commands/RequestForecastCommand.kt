/**
 * Created by hanhvo on 10/11/17.
 */

package com.a.alda.forecastweather.domain.commands

import com.a.alda.forecastweather.domain.datasource.ForecastProvider
import com.a.alda.forecastweather.domain.model.ForecastList

class RequestForecastCommand(
        private val zipCode: Long,
        private val forecastProvider: ForecastProvider = ForecastProvider()) :
        Command<ForecastList> {

    companion object {
        val DAYS = 7
    }

    override fun execute() = forecastProvider.requestByZipCode(zipCode, DAYS)
}