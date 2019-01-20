package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.animation.Animator
import android.animation.ValueAnimator
import android.content.Context
import android.support.v4.view.ViewPager
import android.support.v7.widget.RecyclerView
import android.util.AttributeSet
import android.view.Gravity
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.view.animation.Animation
import android.view.animation.LinearInterpolator
import android.view.animation.RotateAnimation
import android.widget.ImageView
import android.widget.RelativeLayout
import com.exercise.ckaiself.kaiyan_kotlinver.R
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HomeBanner

/**
 * @author Ckai
 * @date 2019/1/16 5:03 PM
 * @description
 */

class PullRecyclerView : RecyclerView {

    constructor(context: Context) : this(context, null)
    constructor(context: Context, attrs: AttributeSet?) : this(context, attrs, 0)
    constructor(context: Context, attrs: AttributeSet?, defStyle: Int) : super(context, attrs, defStyle) {
        overScrollMode = View.OVER_SCROLL_NEVER
    }

    //下拉高度达到300的时候，松开手才会刷新
    val pullDistance = 300
    var originalFirstItemHeight = 0
    var originalFirstItemWeight = 0
    var downY = -1
    //down之后下次up之前，这个是不会变，用来实现loading的缩放比例
    var constDownY = -1
    var constUpY = -1f
    var canRefresh = false
    var isFirstMove = true
    var tempWidth = -1
    var dx = 0
    var homeBanner: HomeBanner? = null

    //松手后可刷新
    var willRefresh = false

    var mLastMotionY = 0f
    var mLastMotionX = 0f
    var deltaY = 0f
    var deltaX = 0f

    var hasShow: Boolean = false
    var onRefreshListener: OnRefreshListener? = null


    //滑动事件拦截
    override fun onInterceptTouchEvent(e: MotionEvent?): Boolean {
        var resume = super.onInterceptTouchEvent(e)
        when (e?.action) {
            MotionEvent.ACTION_DOWN -> {
                //发生down事件时，记录y坐标
                mLastMotionY = e.y
                mLastMotionX = e.x
                downY = e.y.toInt()
                constDownY = e.y.toInt()
                resume = false
            }
            MotionEvent.ACTION_MOVE -> {
                //deltaY >0 是向下运动 <0 是向上运动
                deltaY = e.y.minus(mLastMotionY)
                deltaX = e.x.minus(mLastMotionX)

                if (Math.abs(deltaX) > Math.abs(deltaY)) {
                    resume = false
                } else {
                    //当前正处于滑动
                    //RecyclerView.canScrollVertically(-1);  滑到最顶部时，返回false，意思是不能下拉了
                    if (!canScrollVertically(-1) && !willRefresh) {
                        canRefresh = true
                    }
                    resume = true
                }
            }
            MotionEvent.ACTION_UP -> {
                resume = false
            }
        }
        return resume
    }

    override fun onTouchEvent(e: MotionEvent?): Boolean {

        when (e?.action) {
            MotionEvent.ACTION_DOWN -> {
                downY = e.y.toInt()
                constDownY = e.y.toInt()
                if (!canScrollVertically(-1) && !willRefresh) {
                    canRefresh = true
                }
            }

            MotionEvent.ACTION_MOVE -> {
                if (isFirstMove) {
                    isFirstMove = false
                    if (canRefresh) {
                        canRefresh = e.y - downY > 0
                    }
                }

                if (canRefresh) {
                    if (getChildAt(0) is HomeBanner) {
                        val firstView = getChildAt(0) as HomeBanner
                        if (!hasShow) {
                            showLoading(firstView)
                        }
                        //fl从1-pillDistance 缩放比例0-1
                        var fl = e.y - constDownY
                        if (fl <= 0) {
                            return true
                        }
                        setLoadingScale(fl)

                        val layoutParams = firstView.layoutParams

                        if (layoutParams.height < 0 || tempWidth < 0) {
                            originalFirstItemHeight = getChildViewHolder(firstView).itemView.height
                            originalFirstItemWeight = getChildViewHolder(firstView).itemView.width
                            layoutParams.height = originalFirstItemHeight
                            tempWidth = originalFirstItemWeight
                            firstView.layoutParams = layoutParams
                        } else {

                            var dY = e.y - downY
                            val fl1 = e.y - constDownY

                            val ratio = (1f / (0.004 * fl1 + 1)).toFloat()
                            dY *= ratio
                            layoutParams.height =
                                    (Math.max((layoutParams.height + dY).toInt(), originalFirstItemHeight))
                            tempWidth = (Math.max(
                                    (tempWidth + dY * originalFirstItemWeight / originalFirstItemHeight).toInt(),
                                    originalFirstItemWeight
                            ))
                            downY = e.y.toInt()
                            firstView.layoutParams = layoutParams

                            val viewpager = firstView.getChildAt(0) as ViewPager
                            val viewpagerLayoutParams = viewpager.layoutParams


                            viewpagerLayoutParams.height = layoutParams.height
                            viewpagerLayoutParams.width = tempWidth
                            viewpager.layoutParams = viewpagerLayoutParams

                            dx = viewpagerLayoutParams.width - originalFirstItemWeight

                            adjustViewPager(viewpager, dx)

                        }
                        return true
                    }
                }
            }
            MotionEvent.ACTION_UP -> {
                canRefresh = false
                isFirstMove = true
                constUpY = e.y
                if (getChildAt(0) is HomeBanner) {
                    getChildAt(0)?.let { smoothRecover() }
                }
            }
        }
        return super.onTouchEvent(e)
    }

    //松手后恢复
    private fun smoothRecover() {
        if (originalFirstItemHeight != 0) {
            homeBanner = getChildAt(0) as HomeBanner
            val layoutParams = homeBanner?.layoutParams
            homeBanner?.layoutParams = layoutParams

            val viewpager = homeBanner?.getChildAt(0) as ViewPager
            val viewpagerLayoutParams = viewpager.layoutParams
            if (loading.scaleX == 1f) {
                willRefresh = true
            }
            var dYForView = layoutParams!!.height - originalFirstItemHeight

            val homeBannerAnimator = ValueAnimator.ofInt(layoutParams.height, originalFirstItemHeight)
            homeBannerAnimator
                    .addUpdateListener { animation ->
                        layoutParams.height = animation.animatedValue as Int
                        tempWidth =
                                (animation.animatedValue as Int * (originalFirstItemWeight * 1f / originalFirstItemHeight)).toInt()
                        homeBanner?.layoutParams = layoutParams

                        viewpagerLayoutParams.height = layoutParams.height
                        dx = viewpagerLayoutParams.width - originalFirstItemWeight

                        viewpagerLayoutParams.width = tempWidth
                        viewpager.layoutParams = viewpagerLayoutParams

                        dx = viewpagerLayoutParams.width - originalFirstItemWeight

                        adjustViewPager(viewpager, dx)

                        if (!willRefresh) {
                            //算出来的是从view增加的高度到0的值，需要把它映射到手指滑动的高度到0
                            var distanceY: Float = (layoutParams.height - originalFirstItemHeight) * 1f
                            //映射
                            var fl = distanceY * ((constUpY - constDownY) / dYForView)
                            setLoadingScale(fl)
                        }
                    }

            homeBannerAnimator.addListener(object : Animator.AnimatorListener {
                override fun onAnimationRepeat(p0: Animator?) {

                }

                override fun onAnimationEnd(p0: Animator?) {
                    if (willRefresh) {
                        onRefreshListener?.onRefresh()
                        loading.startAnimation(loadingAnimation)
                    } else {
                        hideLoading()
                    }
                }

                override fun onAnimationCancel(p0: Animator?) {
                }

                override fun onAnimationStart(p0: Animator?) {
                }
            })
            homeBannerAnimator.duration = 100
            homeBannerAnimator.start()

        }
    }


    /**
     * 根据距离原始位置的高度，计算loading缩放值
     */
    private fun setLoadingScale(distanceY: Float) {
        //下拉超过150之后开始逐渐出现loading
        var distance = (distanceY - 150) / pullDistance
        if (distance >= 1) {
            distance = 1f
        } else if (distance < 0) {
            distance = 0f
        }
        loading.scaleX = distance
        loading.scaleY = distance
    }


    fun adjustViewPager(viewPager: ViewPager, dx: Int) {
        viewPager.translationX = -(dx * 1f / 2)
    }


    val loadingAnimation by lazy {
        val rotateAnimation =
                RotateAnimation(0f, 365f, Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF, 0.5f)
        rotateAnimation.duration = 500
        rotateAnimation.repeatCount = -1
        rotateAnimation.interpolator = LinearInterpolator()
        rotateAnimation
    }

    val loading by lazy {
        val imageView = ImageView(context)
        imageView.setImageResource(R.mipmap.eye_loading_progress)
        imageView
    }

    private val loadingView by lazy {
        val frameLayout = RelativeLayout(context)
        frameLayout.setBackgroundColor(0xaa000000.toInt())
        frameLayout.gravity = Gravity.CENTER
        frameLayout.addView(loading)
        frameLayout.layoutParams = ViewGroup.LayoutParams(width, ViewGroup.LayoutParams.MATCH_PARENT)
        frameLayout
    }


    fun showLoading(viewGroup: ViewGroup) {
        hasShow = true
        viewGroup.addView(loadingView)
    }

    fun hideLoading() {
        hasShow = false
        willRefresh = false
        loadingAnimation.cancel()
        homeBanner?.let {
            it.removeView(loadingView)
        }

    }


    interface OnRefreshListener {
        fun onRefresh()
    }


    fun setOnRefreshLinstener(listener: OnRefreshListener) {
        this.onRefreshListener = listener
    }
}