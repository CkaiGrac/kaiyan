package com.exercise.ckaiself.kaiyan_kotlinver.adapter

import android.support.v4.app.Fragment
import android.support.v4.app.FragmentManager
import android.support.v4.app.FragmentPagerAdapter

/**
 * @author Ckai
 * @date 2019/1/20 2:46 PM
 * @description
 */

class HotViewPagerAdapter : FragmentPagerAdapter {

    var titleList: ArrayList<String>? = null
    var fragmentList: ArrayList<Fragment>? = null

    constructor(supportFragmentManager: FragmentManager,
                titleList: ArrayList<String>?,
                fragmentList: ArrayList<Fragment>?) : super(supportFragmentManager) {
        this.titleList = titleList
        this.fragmentList = fragmentList
    }

    override fun getItem(position: Int): Fragment {
        return fragmentList!![position]
    }

    override fun getCount(): Int = if (fragmentList != null) fragmentList!!.size else 0

    override fun getPageTitle(position: Int): CharSequence? {
        return titleList!![position]
    }

}