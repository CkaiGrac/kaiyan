package com.exercise.ckaiself.kaiyan_kotlinver.adapter

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.view.StandardVideoItem

/**
 * @author Ckai
 * @date 2019/1/15 2:10 PM
 * @description
 */

class CategoryDetailAdapter : RecyclerView.Adapter<CategoryDetailAdapter.ViewHolder>() {


    val categorys: ArrayList<Item> by lazy {
        ArrayList<Item>()
    }

    fun addData(itemList: ArrayList<Item>) {
        this.categorys.addAll(itemList)
        notifyDataSetChanged()
    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(StandardVideoItem(parent.context))
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        (holder.itemView as StandardVideoItem).let {
            //TODO setOnlickListener
            it.setData(categorys[position],"categorydetail")
        }
    }

    override fun getItemCount(): Int = categorys.size


    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)

}