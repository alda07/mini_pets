/**
 * Created by hanhvo on 10/11/17.
 */

package com.a.alda.forecastweather.extensions

import java.text.DateFormat
import java.util.*

fun Long.toDateString(dateFormat: Int = DateFormat.MEDIUM): String {
    val df = DateFormat.getDateInstance(dateFormat, Locale.getDefault())
    return df.format(this)
}