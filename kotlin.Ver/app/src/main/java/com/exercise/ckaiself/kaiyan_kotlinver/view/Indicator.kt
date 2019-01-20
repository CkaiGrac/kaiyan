package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.content.Context
import android.graphics.Canvas
import android.graphics.Paint
import android.view.View

/**
 * @author Ckai
 * @date 2019/1/18 4:04 PM
 * @description
 */
class Indicator(context: Context) : View(context) {

    private val paint: Paint

    init {
        paint = Paint()
        paint.isAntiAlias = true
        setState(false)
    }

    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)
        measuredHeight
        measuredWidth
        canvas!!.translate((measuredWidth / 2).toFloat(), (measuredHeight / 2).toFloat())
        canvas.drawCircle(0f, 0f, (measuredWidth / 2).toFloat(), paint)
    }

    fun setState(selected: Boolean) {
        if (selected) {
            paint.color = 0xffffffff.toInt()
        } else {
            paint.color = 0x88ffffff.toInt()
        }
        invalidate()
    }
}