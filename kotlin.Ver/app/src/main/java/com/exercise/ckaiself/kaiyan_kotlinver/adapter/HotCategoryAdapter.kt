package com.exercise.ckaiself.kaiyan_kotlinver.adapter

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import com.exercise.ckaiself.kaiyan_kotlinver.DetailActivity
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.toActivityWithSerializable
import com.exercise.ckaiself.kaiyan_kotlinver.view.HotItem
import com.exercise.ckaiself.kaiyan_kotlinver.view.ListEndView
import kotlinx.android.synthetic.main.layout_list_end.view.*

/**
 * @author Ckai
 * @date 2019/1/20 3:01 PM
 * @description
 */

class HotCategoryAdapter : RecyclerView.Adapter<HotCategoryAdapter.ViewHolder>() {

    val dataList: ArrayList<Item> by lazy { ArrayList<Item>() }

    val TYPE_STANDARD = 1
    val TYPE_END = 2

    fun addItemList(itemList: ArrayList<Item>) {
        dataList.addAll(itemList)
        notifyDataSetChanged()
    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        var itemView = View(parent.context)
        when (viewType) {
            TYPE_STANDARD -> {
                itemView = HotItem(parent.context)
                itemView.layoutParams = RecyclerView.LayoutParams(RecyclerView.LayoutParams.MATCH_PARENT, RecyclerView.LayoutParams.WRAP_CONTENT)
            }
            TYPE_END -> {
                itemView = ListEndView(parent.context)
                itemView.tv_text_end.setTextColor(0xff000000.toInt())
                itemView.layoutParams = RecyclerView.LayoutParams(RecyclerView.LayoutParams.MATCH_PARENT, RecyclerView.LayoutParams.WRAP_CONTENT)
            }
        }
        return ViewHolder(itemView)
    }

    override fun getItemCount(): Int = if (dataList.size == 0) 0 else dataList.size + 1


    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        if(getItemViewType(position) == TYPE_STANDARD){
            (holder.itemView as HotItem).setData(dataList[position])
            holder.itemView.setOnClickListener { v -> v.context.toActivityWithSerializable<DetailActivity>(dataList[position]) }
        }
    }

    override fun getItemViewType(position: Int): Int {
        if (position == dataList.size) {
            return TYPE_END
        } else {
            return TYPE_STANDARD
        }
    }


    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)
}