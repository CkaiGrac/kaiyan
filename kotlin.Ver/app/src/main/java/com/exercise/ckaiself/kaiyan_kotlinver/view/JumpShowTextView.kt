package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.content.Context
import android.graphics.Color
import android.text.TextUtils
import android.util.AttributeSet
import android.view.View
import android.widget.FrameLayout
import com.exercise.ckaiself.kaiyan_kotlinver.io_main
import io.reactivex.Observable
import io.reactivex.disposables.Disposable
import java.util.concurrent.TimeUnit

/**
 * @author Ckai
 * @date 2019/1/18 3:05 PM
 * @description
 */

class JumpShowTextView : FrameLayout {

    val allTime = 700

    var placeHolder: PercentTextView? = null
    var realTextView: PercentTextView? = null
    var withAnimation = true
    var content: String? = ""
    var isBold: Boolean = false
    var color: Int = Color.BLACK
    var singleLine = false

    var textSize: Float = 52f
    //线程是否正在运行
    var isRun: Boolean = false
    var marginBottom: Float = 0f
    var subscribe: Disposable? = null

    fun start() {
        if (withAnimation) {
            if (isRun) {
                subscribe?.dispose()
            }
            content = ""
            isRun = true
            text?.let {
                if (it.length > 0) {
                    val intervalTime = allTime / it.length
                    subscribe = Observable.interval(intervalTime.toLong(), TimeUnit.MILLISECONDS)
                            .take(it.length.toLong())
                            .io_main()
                            .subscribe({ i ->
                                content += it[i.toInt()]
                                realTextView?.text = content
                            }, { e -> e.printStackTrace() }, { isRun = false })
                }
            }
        } else {
            realTextView?.text = text
        }
    }

    var text: String? = ""
        set(value) {
            reCreateObject()
            init()
            field = value
            placeHolder?.text = value
            start()
        }

    private fun reCreateObject() {
        placeHolder = PercentTextView(context)
        placeHolder?.textSize = textSize
        placeHolder?.layoutParams = LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT)
        placeHolder?.visibility = View.INVISIBLE

        realTextView = PercentTextView(context)
        realTextView?.setTextColor(color)
        realTextView?.textSize = textSize
        realTextView?.paint?.isFakeBoldText = isBold
        realTextView?.layoutParams = LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT)

        if (singleLine) {
            placeHolder?.setSingleLine(singleLine)
            placeHolder?.ellipsize = TextUtils.TruncateAt.END
            realTextView?.ellipsize = TextUtils.TruncateAt.END
            realTextView?.setSingleLine(singleLine)
        }
    }

    private fun init() {
        removeAllViews()
        addView(placeHolder)
        addView(realTextView)
    }


    constructor(context: Context?) : this(context, null)
    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs)


}