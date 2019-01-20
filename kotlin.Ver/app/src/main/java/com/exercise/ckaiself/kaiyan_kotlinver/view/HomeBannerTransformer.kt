package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.support.v4.view.ViewPager
import android.view.View

/**
 * @author Ckai
 * @date 2019/1/18 4:44 PM
 * @description
 */

class HomeBannerTransformer : ViewPager.PageTransformer {

    override fun transformPage(page: View, position: Float) {
        val width: Int = page.width
        page.scrollX = (position * width).toInt() / 4 * 3
    }
}