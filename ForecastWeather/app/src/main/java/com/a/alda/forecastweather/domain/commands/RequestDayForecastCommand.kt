/**
 * Created by hanhvo on 10/11/17.
 */

package com.a.alda.forecastweather.domain.commands

import com.a.alda.forecastweather.domain.datasource.ForecastProvider
import com.a.alda.forecastweather.domain.model.Forecast

class RequestDayForecastCommand(
        val id: Long,
        private val forecastProvider: ForecastProvider = ForecastProvider()) :
        Command<Forecast> {

    override fun execute() = forecastProvider.requestForecast(id)
}
