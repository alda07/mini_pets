/**
 * Created by hanhvo on 10/11/17.
 */

package com.a.alda.forecastweather.ui

import android.app.Application
import com.a.alda.forecastweather.extensions.DelegatesExt

class App : Application() {

    companion object {
        var instance: App by DelegatesExt.notNullSingleValue()
    }

    override fun onCreate() {
        super.onCreate()
        instance = this
    }
}