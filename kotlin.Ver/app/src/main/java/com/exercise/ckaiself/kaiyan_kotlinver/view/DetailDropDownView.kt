package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.content.Context
import android.support.v7.widget.LinearLayoutManager
import android.util.AttributeSet
import android.view.View
import android.widget.RelativeLayout
import com.exercise.ckaiself.kaiyan_kotlinver.R
import com.exercise.ckaiself.kaiyan_kotlinver.adapter.DetailDropDownAdapter
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import kotlinx.android.synthetic.main.layout_detail_drop_down.view.*

/**
 * @author Ckai
 * @date 2019/1/23 10:36 AM
 * @description
 */

class DetailDropDownView : RelativeLayout {

    val adapter by lazy {
        DetailDropDownAdapter()
    }

    var onVideoClick: ((Item) -> Unit)? = {}
        set(value) {
            (rv_detail_more.adapter as DetailDropDownAdapter).onVideoClick = value
        }


    constructor(context: Context?) : this(context, null)
    constructor(context: Context?, attrs: AttributeSet?) : this(context, attrs, 0)
    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr) {
        init()
    }

    private fun init() {
        View.inflate(context, R.layout.layout_detail_drop_down, this)
        rv_detail_more.layoutManager = LinearLayoutManager(context)
        rv_detail_more.adapter = adapter
    }

    fun setDropDownData(items: ArrayList<Item>) {
        adapter.setData(items)
    }

    fun addDropDownData(items: ArrayList<Item>) {
        adapter.addData(items)
    }

    fun addDropDownData(item: Item) {
        adapter.addData(item)
    }



}