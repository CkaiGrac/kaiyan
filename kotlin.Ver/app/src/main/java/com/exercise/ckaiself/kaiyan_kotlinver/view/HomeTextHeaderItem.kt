package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.content.Context
import android.graphics.Color
import android.graphics.Typeface
import android.util.AttributeSet
import android.view.Gravity
import android.widget.FrameLayout
import android.widget.TextView


/**
 * @author Ckai
 * @date 2019/1/17 11:25 AM
 * @description
 */
class HomeTextHeaderItem : FrameLayout {

    private val textView by lazy {
        TextView(context)
    }

    constructor(context: Context?) : this(context, null)
    constructor(context: Context?, attrs: AttributeSet?) : this(context, attrs, 0)
    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr) {
        init()
    }

    private fun init() {
        textView.gravity = Gravity.CENTER
        textView.textSize = 20f
        textView.typeface = Typeface.createFromAsset(context?.assets, "fonts/Lobster-1.4.otf")
        val paint = textView.paint
        paint.isFakeBoldText = true
        textView.setTextColor(Color.BLACK)
        addView(textView)
    }

    fun setHeaderText(text: String?) {
        textView.text = text
    }
}