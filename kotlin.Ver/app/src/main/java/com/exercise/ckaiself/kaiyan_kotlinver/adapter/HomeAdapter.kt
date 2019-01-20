package com.exercise.ckaiself.kaiyan_kotlinver.adapter

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HomeBanner
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.util.DisplayManager
import com.exercise.ckaiself.kaiyan_kotlinver.view.HomeTextHeaderItem
import com.exercise.ckaiself.kaiyan_kotlinver.view.StandardVideoItem

/**
 * @author Ckai
 * @date 2019/1/19 11:09 AM
 * @description
 */

class HomeAdapter : RecyclerView.Adapter<HomeAdapter.ViewHolder>() {

    var isNewBanner = false
    private val TYPE_BANNER = 1
    private val TYPE_STANDARD = 2
    private val TYPE_HEADER_TEXT = 3

    //只会在banner数据请求到的时候set，其他都是add，所以通过set可以获取到banner的count
    var itemList: ArrayList<Item> = ArrayList()
        set(value) {
            field = value
            isNewBanner = true
            notifyDataSetChanged()
        }

    //banner用了的item的数量，包括type为banner2的
    var bannerItemListCount = 0

    fun addData(itemList: ArrayList<Item>) {
        this.itemList.addAll(itemList)
        notifyDataSetChanged()
    }

    fun setBannerSize(size: Int) {
        bannerItemListCount = size
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        when (viewType) {
            TYPE_BANNER -> {
                return ViewHolder(HomeBanner(parent!!.context))
            }

            TYPE_STANDARD -> {
                val textView = StandardVideoItem(parent!!.context)
                return ViewHolder(textView)
            }

            TYPE_HEADER_TEXT -> {
                val headerText = HomeTextHeaderItem(parent!!.context)
                headerText.layoutParams = RecyclerView.LayoutParams(RecyclerView.LayoutParams.MATCH_PARENT,
                        DisplayManager.dip2px(56f)!!)
                return ViewHolder(headerText)
            }
            else -> {
                return ViewHolder(View(parent.context))
            }

        }
    }

    override fun getItemCount(): Int {
        if (itemList.size > bannerItemListCount) {
            return itemList.size - bannerItemListCount + 1
        } else if (itemList.size == 0) {
            return 0
        } else {
            return 1
        }
    }

    override fun getItemViewType(position: Int): Int {
        if (position == 0) {
            return TYPE_BANNER
        }
        if (itemList[position + bannerItemListCount - 1].type == "textHeader") {
            return TYPE_HEADER_TEXT
        } else {
            return TYPE_STANDARD
        }
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val itemViewType = getItemViewType(position)
        when (itemViewType) {
            TYPE_BANNER -> {
                if (isNewBanner) {
                    isNewBanner = false
                    (holder?.itemView as HomeBanner).setData(itemList.take(bannerItemListCount).toCollection(ArrayList()))
                }
            }
            TYPE_STANDARD -> (holder?.itemView as StandardVideoItem).let {
                //TODO setOnClickListener
                it.setData(itemList[position + bannerItemListCount - 1], "feed")
            }
            TYPE_HEADER_TEXT -> {
                (holder?.itemView as HomeTextHeaderItem).setHeaderText(itemList[position + bannerItemListCount - 1].data?.text)
            }
        }
    }


    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)


}