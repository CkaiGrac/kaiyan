package com.exercise.ckaiself.kaiyan_kotlinver.adapter

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.view.DetailReplyTitleView
import com.exercise.ckaiself.kaiyan_kotlinver.view.DetailReplyView
import com.exercise.ckaiself.kaiyan_kotlinver.view.DetailVideoCardView
import com.exercise.ckaiself.kaiyan_kotlinver.view.ListEndView

/**
 * @author Ckai
 * @date 2019/1/23 10:46 AM
 * @description
 */

class DetailDropDownAdapter : RecyclerView.Adapter<DetailDropDownAdapter.ViewHolder>() {

    val TYPE_VIDEO = 1
    val TYPE_REPLY = 2
    val TYPE_END = 3
    val TYPE_REPLY_TITLE = 4
    var onVideoClick: ((Item) -> Unit)? = {}
    val data by lazy { ArrayList<Item>() }

    fun addData(itemList: ArrayList<Item>) {
        data.addAll(itemList)
        notifyDataSetChanged()
    }

    fun addData(item: Item) {
        if (data[data.size - 1].data == null) {
            return
        }
        data.add(item)
        notifyDataSetChanged()
    }

    fun setData(itemList: ArrayList<Item>) {
        data.clear()
        notifyDataSetChanged()
        addData(itemList)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        var itemView: View
        when (viewType) {
            TYPE_VIDEO -> {
                itemView = DetailVideoCardView(parent.context)
            }
            TYPE_REPLY -> {
                itemView = DetailReplyView(parent.context)
            }
            TYPE_END -> {
                itemView = ListEndView(parent.context)
                itemView.layoutParams = RecyclerView.LayoutParams(RecyclerView.LayoutParams.MATCH_PARENT, RecyclerView.LayoutParams.WRAP_CONTENT)
            }
            TYPE_REPLY_TITLE -> {
                itemView = DetailReplyTitleView(parent.context)
            }
            else -> {
                throw IllegalArgumentException("api出错")
            }
        }
        return ViewHolder(itemView)
    }

    override fun getItemCount(): Int = data.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val itemView = holder.itemView
        when (getItemViewType(position)) {
            TYPE_VIDEO -> {
                (itemView as DetailVideoCardView).setData(data[position], false)
                itemView.setOnClickListener { onVideoClick?.invoke(data[position]) }
            }

            TYPE_REPLY_TITLE -> {
                (itemView as DetailReplyTitleView).setText(data[position])
            }

            TYPE_REPLY -> {
                (itemView as DetailReplyView).setData(data[position])
            }

            else -> {

            }
        }
    }

    override fun getItemViewType(position: Int): Int {

        if (data[position].data == null) {
            return TYPE_END
        }
        when (data[position].type) {

            "reply" -> {
                return TYPE_REPLY
            }

            "leftAlignTextHeader" -> {
                return TYPE_REPLY_TITLE
            }

            "videoSmallCard" -> {
                return TYPE_VIDEO
            }
        }
        return super.getItemViewType(position)
    }

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)
}