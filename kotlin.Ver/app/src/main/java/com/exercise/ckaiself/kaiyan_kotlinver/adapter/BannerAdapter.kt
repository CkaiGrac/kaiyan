package com.exercise.ckaiself.kaiyan_kotlinver.adapter

import android.support.v4.view.PagerAdapter
import android.view.View
import android.view.ViewGroup
import com.exercise.ckaiself.kaiyan_kotlinver.DetailActivity
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.toActivityWithSerializable
import com.exercise.ckaiself.kaiyan_kotlinver.view.HomeBannerItem

/**
 * @author Ckai
 * @date 2019/1/16 5:20 PM
 * @description
 */

class BannerAdapter : PagerAdapter() {

    var datas: ArrayList<Item>? = null
    var viewList: ArrayList<HomeBannerItem> = ArrayList()


    override fun isViewFromObject(view: View, obj: Any): Boolean {
        return view == obj
    }

    override fun getCount(): Int {
        if (datas == null) {
            return 0
        } else {
            return datas!!.size
        }
    }

    override fun destroyItem(container: ViewGroup, position: Int, `object`: Any) {
        container.removeView(viewList[position])
        viewList[position].releasePlayer()
    }

    override fun instantiateItem(container: ViewGroup, position: Int): Any {
        if(viewList.size <= position){
            val homeBannerItem = HomeBannerItem(container.context, datas!![position])
            viewList.add(homeBannerItem)
        }
        val view = viewList[position]
        container.addView(view)
        viewList[position].play()
        //view.setOnClickListener{ v -> v.context.toActivityWithSerializable<>()}
        view.setOnClickListener { v->v.context.toActivityWithSerializable<DetailActivity>(datas!![position]) }
        return view
    }

}