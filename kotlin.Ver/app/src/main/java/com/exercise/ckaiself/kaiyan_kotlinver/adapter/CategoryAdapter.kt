package com.exercise.ckaiself.kaiyan_kotlinver.adapter

import android.graphics.Color
import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Category
import com.exercise.ckaiself.kaiyan_kotlinver.view.CategoryItem
import com.exercise.ckaiself.kaiyan_kotlinver.view.ListEndView
import kotlinx.android.synthetic.main.layout_list_end.view.*

/**
 * @author Ckai
 * @date 2019/1/11 9:53 PM
 * @description
 */

class CategoryAdapter : RecyclerView.Adapter<CategoryAdapter.ViewHolder>() {

    private val TYPE_STANDARD = 1
    private val TYPE_END = 2

    val data by lazy {
        ArrayList<Category>()
    }

    fun setData(data: ArrayList<Category>) {
        this.data.addAll(data)
        notifyDataSetChanged()
    }


    override fun getItemCount(): Int = if (data.size == 0) 0 else data.size + 1

    override fun getItemViewType(position: Int): Int {
        if (data.size == position) {
            return TYPE_END
        }
        return TYPE_STANDARD
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        var itemView = View(parent.context)
        when (viewType) {
            TYPE_END -> {
                itemView = ListEndView(parent.context)
                itemView.layoutParams = RecyclerView.LayoutParams(RecyclerView.LayoutParams.MATCH_PARENT, RecyclerView.LayoutParams.WRAP_CONTENT)
                itemView.tv_text_end.setTextColor(Color.BLACK)
            }
            TYPE_STANDARD -> {
                itemView = CategoryItem(parent.context)
            }
        }
        return CategoryAdapter.ViewHolder(itemView)
    }


    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val itemViewType = getItemViewType(position)
        when (itemViewType) {
            TYPE_STANDARD -> {
                (holder.itemView as CategoryItem).setData(data[position])
                holder.itemView.setOnClickListener { onClick?.invoke(data[position]) }
            }
        }
    }


    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)

    var onClick: ((Category) -> Unit)? = {}
}