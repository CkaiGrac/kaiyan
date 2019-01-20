package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.content.Context
import android.util.AttributeSet
import android.view.View
import android.widget.FrameLayout
import com.bumptech.glide.Glide
import com.exercise.ckaiself.kaiyan_kotlinver.R
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Category
import kotlinx.android.synthetic.main.layout_category_item.view.*

/**
 * @author Ckai
 * @date 2019/1/12 10:52 AM
 * @description
 */

class CategoryItem : FrameLayout {


    constructor(context: Context?) : this(context, null)
    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs) {
        initView()
    }

    private fun initView() {
        View.inflate(context, R.layout.layout_category_item, this)
    }

    fun setData(category: Category) {
        tv_name.text = "#" + category.name
        Glide.with(context).load(category.bgPicture).centerCrop().into(iv_category)
    }

}