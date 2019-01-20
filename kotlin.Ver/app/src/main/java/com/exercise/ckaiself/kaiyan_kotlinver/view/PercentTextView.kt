package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.content.Context
import android.support.v7.widget.AppCompatTextView
import android.util.AttributeSet
import android.util.TypedValue
import android.view.WindowManager
import com.exercise.ckaiself.kaiyan_kotlinver.R

/**
 * @author Ckai
 * @date 2019/1/12 10:58 AM
 * @description
 */
class PercentTextView : AppCompatTextView {
    private var mTextSizePercent = 1f

    constructor(context: Context) : super(context) {
        setDefaultPercent(context)
        textSize = textSize
    }

    constructor(context: Context, attrs: AttributeSet) : super(context, attrs) {
        getAttrs(context, attrs)
        setDefaultPercent(context)
        textSize = textSize
    }

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(context, attrs, defStyleAttr) {
        getAttrs(context, attrs)
        setDefaultPercent(context)
        textSize = textSize
    }


    override fun setTextSize(unit: Int, size: Float) {
        var varSize = size
        varSize = (varSize * mTextSizePercent).toInt().toFloat()
        super.setTextSize(unit, varSize)
    }

    override fun setPaintFlags(flags: Int) {
        super.setPaintFlags(flags)
    }

    override fun setTextSize(size: Float) {
        setTextSize(TypedValue.COMPLEX_UNIT_PX, size)
    }

    var textSizePercent: Float
        get() = mTextSizePercent
        set(textSizePercent) {
            mTextSizePercent = textSizePercent
            setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize)
        }

    private fun setDefaultPercent(context: Context) {
        val screenHeight = getScreenHeight(context).toFloat()
        mTextSizePercent = screenHeight / baseScreenHeight
    }

    fun setTextSizePercent(unit: Int, textSizePercent: Float) {
        mTextSizePercent = textSizePercent
        setTextSize(unit, textSize)
    }


    /**
     * 得到自定义属性
     */
    private fun getAttrs(context: Context, attrs: AttributeSet) {
        val ta = context.obtainStyledAttributes(attrs, R.styleable.PercentTextView)
        baseScreenHeight = ta.getInt(R.styleable.PercentTextView_baseScreenHeight, baseScreenHeight)
        ta.recycle()
    }


    companion object {

        private var baseScreenHeight = 1920
        /**
         * 获取当前设备的屏幕宽度
         */
        fun getScreenHeight(context: Context): Int {
            val wm = context
                    .getSystemService(Context.WINDOW_SERVICE) as WindowManager
            return wm.defaultDisplay.height
        }

    }


}