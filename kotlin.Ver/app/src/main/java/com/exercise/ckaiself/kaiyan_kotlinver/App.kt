package com.exercise.ckaiself.kaiyan_kotlinver

import android.app.Application
import com.exercise.ckaiself.kaiyan_kotlinver.util.DisplayManager

/**
 * @author Ckai
 * @date 2019/1/12 3:49 PM
 * @description
 */

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        DisplayManager.init(this)
    }
}