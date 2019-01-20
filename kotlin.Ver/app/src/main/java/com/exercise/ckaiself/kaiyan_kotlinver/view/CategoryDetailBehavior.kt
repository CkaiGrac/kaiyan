package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.animation.ValueAnimator
import android.content.Context
import android.support.design.widget.CoordinatorLayout
import android.support.v4.view.ViewCompat
import android.support.v7.widget.RecyclerView
import android.util.AttributeSet
import android.util.Log
import android.view.View

/**
 * @author Ckai
 * @date 2019/1/14 2:55 PM
 * @description
 */

class CategoryDetailBehavior(context: Context?, attrs: AttributeSet?) :
    CoordinatorLayout.Behavior<RecyclerView>(context, attrs) {

    //header
    var header: CategoryHeaderView? = null
    //recyclerview
    var recyclerView: RecyclerView? = null
    var parent: CoordinatorLayout? = null
    //header根据recyclerview的改变而改变
    var parentHeight = 0
    var isFirstLayoutChild = true

    //确定child和dependency（behavior作用于recyclerview ,所以它叫child）
    override fun layoutDependsOn(parent: CoordinatorLayout, child: RecyclerView, dependency: View): Boolean {
        if (header == null) {
            header = dependency as CategoryHeaderView?
        }
        if (recyclerView == null) {
            recyclerView = child
        }
        if (parent == null) {
            this.parent = parent
        }
        if (parentHeight == 0) {
            parentHeight = parent!!.layoutParams.height
        }
        return true
    }

    override fun onLayoutChild(parent: CoordinatorLayout, child: RecyclerView, layoutDirection: Int): Boolean {
        if (isFirstLayoutChild) {
            setRecyclerViewState(header!!.height)
            isFirstLayoutChild = false
        }
        return super.onLayoutChild(parent, child, layoutDirection)
    }

    override fun onDependentViewChanged(parent: CoordinatorLayout, child: RecyclerView, dependency: View): Boolean {
        Log.i("CategoryDetailBehavior", "onDependentViewChanged-->${1}")
        return super.onDependentViewChanged(parent, child, dependency)
    }

    //竖直方向全部接收
    override fun onStartNestedScroll(
        coordinatorLayout: CoordinatorLayout,
        child: RecyclerView,
        directTargetChild: View,
        target: View,
        nestedScrollAxes: Int
    ): Boolean {
        return nestedScrollAxes == ViewCompat.SCROLL_AXIS_VERTICAL
    }

    override fun onNestedPreScroll(
        coordinatorLayout: CoordinatorLayout,
        child: RecyclerView,
        target: View,
        dx: Int,
        dy: Int,
        consumed: IntArray,
        type: Int
    ) {
        //只要recyclerview的位置大于header的最小值，就不能上下滑动
        if (!hasCollapsed()) {
            //recyclerview应该距离顶部的高度
            val marginTop = (recyclerView!!.translationY - dy).toInt()
            if ((marginTop <= header!!.getMaxHeight()) && marginTop >= header!!.getMinHeight()) {
                setRecyclerViewState(marginTop)
            } else if (marginTop < header!!.getMinHeight()) {
                setRecyclerViewState(header!!.getMinHeight())
            } else if (marginTop > header!!.getMaxHeight()) {
                setRecyclerViewState(header!!.getMaxHeight())
            }
            consumed!![1] = dy
        } else {
            //如果recyclerview不能下滑
            if (!canSlideBottom()) {
                if (dy < 0) {
                    //recyclerview应该距离顶部的高度
                    val marginTop = (recyclerView!!.translationY - dy).toInt()
                    setRecyclerViewState(marginTop)
                    consumed!![1] = dy
                }
            }
        }
    }

    override fun onStopNestedScroll(coordinatorLayout: CoordinatorLayout, child: RecyclerView, target: View) {
        playAnimator()
    }


    override fun onNestedFling(
        coordinatorLayout: CoordinatorLayout,
        child: RecyclerView,
        target: View,
        velocityX: Float,
        velocityY: Float,
        consumed: Boolean
    ): Boolean {
        return true
    }

    override fun onNestedPreFling(
        coordinatorLayout: CoordinatorLayout,
        child: RecyclerView,
        target: View,
        velocityX: Float,
        velocityY: Float
    ): Boolean {
        if (!hasCollapsed()) {//header没有缩回去
            return true
        }
        return super.onNestedPreFling(coordinatorLayout, child, target, velocityX, velocityY)
    }

    /**
     * 是否可以手指上滑
     */
    private fun canSlideTop(): Boolean {
        return recyclerView!!.canScrollVertically(1)
    }


    /**
     * 是否可以手指下滑
     */
    private fun canSlideBottom(): Boolean {
        return recyclerView!!.canScrollVertically(-1)
    }


    /**
     * 设置recyclerview距离上面的距离以及高度
     */
    private fun setRecyclerViewState(height: Int) {
        val temp = header!!.getMinHeight() - header!!.getMaxHeight()
        val progress = height * 1f / temp - header!!.getMaxHeight() * 1f / temp
        Log.i("CategoryDetailBehavior", "setRecyclerViewState-->${progress}")
        //(1f / (header!!.getMinHeight() - header!!.getMaxHeight()) * height - (1f / (header!!.getMinHeight() - header!!.getMaxHeight())))
        header!!.setCollapsedProgress(progress)
        recyclerView!!.setTranslationY(height.toFloat())
    }

    /**
     * header是否收回去了
     */
    private fun hasCollapsed(): Boolean {
        val translationY = recyclerView?.translationY
        if ((translationY!! > header!!.getMinHeight())) {
            return false
        }
        return true
    }

    /**
     * 展开、合上进行了一半，松手后动画播放
     */
    private fun playAnimator() {
        val translationY = recyclerView!!.translationY
        val middle = (header!!.getMinHeight() + header!!.getMaxHeight()) / 2f
        var end: Int

        if ((translationY > middle)) {
            end = header!!.getMaxHeight()
        } else {
            end = header!!.getMinHeight()
        }

        val valueAnimator = ValueAnimator.ofInt(translationY.toInt(), end)
        valueAnimator.addUpdateListener { animation ->
            val animatedValue = animation.animatedValue as Int
            setRecyclerViewState(animatedValue)
        }
        valueAnimator.duration = 100
        valueAnimator.start()
    }

}