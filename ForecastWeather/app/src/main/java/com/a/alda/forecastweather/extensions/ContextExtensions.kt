/**
 * Created by hanhvo on 10/11/17.
 */

package com.a.alda.forecastweather.extensions

import android.content.Context
import android.support.v4.content.ContextCompat

fun Context.color(res: Int): Int = ContextCompat.getColor(this, res)