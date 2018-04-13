/**
 * Created by hanhvo on 10/11/17.
 */

package com.a.alda.forecastweather.domain.commands

interface Command<out T> {
    fun execute(): T
}