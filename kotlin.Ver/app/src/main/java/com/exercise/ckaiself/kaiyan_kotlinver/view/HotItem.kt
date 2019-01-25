package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.content.Context
import android.util.AttributeSet
import android.view.View
import android.widget.FrameLayout
import com.bumptech.glide.Glide
import com.exercise.ckaiself.kaiyan_kotlinver.R
import com.exercise.ckaiself.kaiyan_kotlinver.durationFormat
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import kotlinx.android.synthetic.main.layout_hot_item.view.*

/**
 * @author Ckai
 * @date 2019/1/20 3:07 PM
 * @description
 */

class HotItem : FrameLayout {


    constructor(context: Context?) : this(context, null)
    constructor(context: Context?, attrs: AttributeSet?) : this(context, attrs, 0)
    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr) {
        initView()
    }

    private fun initView() {
        View.inflate(context, R.layout.layout_hot_item, this)
    }

    fun setData(item: Item) {
        jst_name.text = item.data?.title
        jst_tag.text = "#" + item.data?.category + " / " + durationFormat(item.data?.duration)
        Glide.with(context).load(item.data?.cover?.feed).centerCrop().into(this.hot_image)
    }

}