package com.exercise.ckaiself.kaiyan_kotlinver

import android.content.pm.ActivityInfo
import android.content.res.Configuration
import android.graphics.Bitmap
import android.graphics.Matrix
import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.util.Log
import android.view.ViewTreeObserver
import android.view.animation.Animation
import android.view.animation.TranslateAnimation
import android.widget.RelativeLayout
import com.bumptech.glide.BitmapRequestBuilder
import com.bumptech.glide.Glide
import com.bumptech.glide.load.DecodeFormat
import com.bumptech.glide.load.engine.bitmap_recycle.BitmapPool
import com.bumptech.glide.load.resource.bitmap.BitmapTransformation
import com.exercise.ckaiself.kaiyan_kotlinver.adapter.DetailAdapter
import com.exercise.ckaiself.kaiyan_kotlinver.base.BaseActivity
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract.DetailContract
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Issue
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.presenter.DetailPresenter
import com.exercise.ckaiself.kaiyan_kotlinver.view.*
import com.shuyu.gsyvideoplayer.GSYVideoManager
import com.shuyu.gsyvideoplayer.video.StandardGSYVideoPlayer
import com.shuyu.gsyvideoplayer.video.base.GSYVideoPlayer
import io.reactivex.disposables.Disposable
import kotlinx.android.synthetic.main.activity_detail.*
import kotlinx.android.synthetic.main.layout_detail_drop_down.view.*
import java.util.*

class DetailActivity : BaseActivity(), DetailContract.IView {

    lateinit var presenter: DetailPresenter
    val adapter by lazy { DetailAdapter() }
    var itemData: Item? = null
    //dropdown里请求的数据的disposable，需要在销毁的时候dispose
    var dropDownDisPoseable: Disposable? = null
    val dropDownViews = Stack<DetailDropDownView>()
    var backgoundBuilder: BitmapRequestBuilder<String, Bitmap>? = null
    var loadingMore = false
    var dropDownHeight = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        presenter = DetailPresenter(this)
        setContentView(R.layout.activity_detail)
        initView()
        loadData()
    }

    private fun initView() {
        rv_detail.layoutManager = LinearLayoutManager(this)
        rv_detail.adapter = adapter
        initListener()
        videoView.isRotateViewAuto = false
        videoView.fullscreenButton.setOnClickListener {
            if (this.resources.configuration.orientation == Configuration.ORIENTATION_PORTRAIT) {
                requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE
            }
            videoView.startWindowFullscreen(this, true, true)
        }

    }

    private fun initListener() {
        adapter.setOnItemClick(
                { presenter.requestBasicDataFromMemory(it) },
                { url, title -> dropDownDisPoseable = presenter.requestRelatedAllList(url!!, title!!) },
                {
                    when (it) {
                        BTN_AUTHOR -> showToast("作者详情（未实现）")
                        BTN_DOWLOAD -> showToast("下载（未实现）")
                        BTN_REPLY -> presenter.requestReply(itemData?.data?.id!!)
                        BTN_FAVORITES -> showToast("喜欢（未实现）")
                        BTN_WATCH -> showToast("加关注（未实现）")
                        BTN_SHARE -> showToast("分享（未实现）")
                    }
                }
        )
    }


    private fun loadData() {
        itemData = intent.getSerializableExtra("data") as Item
        presenter.requestBasicDataFromMemory(itemData!!)
    }

    override fun setPlayer(playUrl: String) {
        videoView.setUp(playUrl, false, "")
        videoView.startPlayLogic()
    }

    override fun setMovieAuthorInfo(info: Item) {
        itemData = info
        adapter.addData(info)
    }

    override fun setRelted(itemList: ArrayList<Item>) {
        adapter.addData(itemList)
    }

    override fun setBackground(url: String) {
        backgoundBuilder = Glide.with(this).load(url).asBitmap()
                .transform(object : BitmapTransformation(this) {
                    override fun getId(): String {
                        return ""
                    }

                    override fun transform(pool: BitmapPool?, toTransform: Bitmap?, outWidth: Int, outHeight: Int): Bitmap {
                        val matrix = Matrix()
                        matrix.postRotate(90f)
                        return Bitmap.createBitmap(toTransform, 0, 0, toTransform!!.width, toTransform.height, matrix, true)
                    }
                })
                .format(DecodeFormat.PREFER_ARGB_8888).centerCrop()
        backgoundBuilder?.into(background)
    }

    override fun showDropDownView(title: String) {
        val detailDropDownView = DetailDropDownView(this)
        detailDropDownView.title.text = title
        val layoutParams = RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.MATCH_PARENT,
                RelativeLayout.LayoutParams.MATCH_PARENT
        )
        layoutParams.addRule(RelativeLayout.BELOW, videoView.id)
        detailDropDownView.layoutParams = layoutParams
        backgoundBuilder?.into(detailDropDownView.iv_background)
        root.addView(detailDropDownView)
        dropDownViews.push(detailDropDownView)
        playDropDownAnimation(detailDropDownView, true)
        detailDropDownView.closeButton.setOnClickListener { closeDropDownView() }

        detailDropDownView.rv_detail_more.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                if (newState == RecyclerView.SCROLL_STATE_IDLE) {
                    val childCount = detailDropDownView.rv_detail_more.getChildCount()
                    val itemCount = detailDropDownView.rv_detail_more.layoutManager?.getItemCount()
                    val firstVisibleItem =
                            (detailDropDownView.rv_detail_more.layoutManager as LinearLayoutManager).findFirstVisibleItemPosition()
                    if (firstVisibleItem + childCount == itemCount) {
                        Log.d(TAG, "到底了")
                        if (!loadingMore) {
                            loadingMore = true
                            onLoadMore(title)
                        }
                    }
                }
            }
        })
        detailDropDownView.onVideoClick = { item ->
            closeDropDownView()
            presenter.requestBasicDataFromMemory(item)
        }

    }

    override fun setDropDownView(issue: Issue) {
        val topDropDownView = dropDownViews[dropDownViews.size - 1]
        topDropDownView.setDropDownData(issue.itemList)
    }


    override fun setMoreDropDownView(issue: Issue?) {
        loadingMore = false
        val topDropDownView = dropDownViews[dropDownViews.size - 1]
        issue?.let {
            topDropDownView.addDropDownData(issue.itemList)
            return
        }
        topDropDownView.addDropDownData(Item("", null, ""))
    }

    override fun onResume() {
        super.onResume()
        GSYVideoManager.onResume()
    }

    override fun onPause() {
        super.onPause()
        GSYVideoManager.onPause()
    }

    override fun onDestroy() {
        super.onDestroy()
        GSYVideoPlayer.releaseAllVideos()
    }

    fun playDropDownAnimation(view: DetailDropDownView, show: Boolean) {
        var translateAnimation: Animation
        if (dropDownHeight == 0) {
            view.viewTreeObserver.addOnGlobalLayoutListener(object : ViewTreeObserver.OnGlobalLayoutListener {

                override fun onGlobalLayout() {
                    if (dropDownHeight != 0) {
                        view.viewTreeObserver.removeOnGlobalLayoutListener(this)
                    } else {
                        dropDownHeight = view.height
                        translateAnimation = TranslateAnimation(0f, 0f, dropDownHeight.toFloat(), 0f)
                        translateAnimation.duration = 100
                        view.startAnimation(translateAnimation)
                    }
                }
            })
        } else {
            if (show) {
                translateAnimation = TranslateAnimation(0f, 0f, dropDownHeight.toFloat(), 0f)
            } else {
                translateAnimation = TranslateAnimation(0f, 0f, 0f, dropDownHeight.toFloat())
            }
            translateAnimation.duration = 100
            view.startAnimation(translateAnimation)
        }
    }

    fun closeDropDownView(): Boolean {
        if (dropDownViews.size == 0) {
            return false
        }
        if (dropDownDisPoseable != null && !(dropDownDisPoseable?.isDisposed!!)) {
            dropDownDisPoseable?.dispose()
        }
        playDropDownAnimation(dropDownViews[dropDownViews.size - 1], false)
        root.removeView(dropDownViews[dropDownViews.size - 1])
        dropDownViews.pop()
        return true
    }

    override fun onBackPressed() {
        if (StandardGSYVideoPlayer.backFromWindowFull(this)) {
            if (this.resources.configuration.orientation != Configuration.ORIENTATION_PORTRAIT) {
                requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
            }
            return
        }
        val closeMoreList = closeDropDownView()
        if (closeMoreList) {
            return
        }
        super.onBackPressed()
    }

    fun onLoadMore(title: String) {
        if (title.contains("评论")) {
            dropDownDisPoseable = presenter.requestMoreReply()
        } else {
            dropDownDisPoseable = presenter.requestRelatedAllMoreList()
        }
    }

    override fun onConfigurationChanged(newConfig: Configuration?) {
        super.onConfigurationChanged(newConfig)
        videoView?.fullWindowPlayer?.fullscreenButton?.setOnClickListener {
            GSYVideoPlayer.backFromWindowFull(this)
            if (this.resources.configuration.orientation != Configuration.ORIENTATION_PORTRAIT) {
                requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT;
            }
        }
    }

}
