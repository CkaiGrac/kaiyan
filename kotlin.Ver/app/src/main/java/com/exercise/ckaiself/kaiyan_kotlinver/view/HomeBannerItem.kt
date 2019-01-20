package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import com.bumptech.glide.Glide
import com.exercise.ckaiself.kaiyan_kotlinver.R
import com.exercise.ckaiself.kaiyan_kotlinver.TAG
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.player.EmptyControlVideo
import com.shuyu.gsyvideoplayer.utils.GSYVideoType
import com.shuyu.gsyvideoplayer.video.base.GSYVideoPlayer
import kotlinx.android.synthetic.main.item_home_banner.view.*

/**
 * @author Ckai
 * @date 2019/1/16 5:22 PM
 * @description
 */

class HomeBannerItem : FrameLayout {

    lateinit var data: Item
    var isVideo = false
    var isInitVideoView = false

    constructor(context: Context?, data: Item) : super(context) {
        this.data = data
        initView()
        setUpView()
    }

    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr)


    private fun initView() {
        val view = View.inflate(context, R.layout.item_home_banner, null)
        addView(view)
    }


    fun setUpView() {
        val thumbPlayUrl = data.data?.thumbPlayUrl

        imageView.visibility = View.VISIBLE
        val feedImgUrl = data.data?.cover?.feed
        Glide.with(context).load(feedImgUrl).centerCrop().into(imageView)

        if (thumbPlayUrl == null || "".equals(thumbPlayUrl)) {
            isVideo = false
            videoView.visibility = View.GONE
        } else {
            isVideo = true
            videoView.visibility = View.VISIBLE
            videoView.setUp(thumbPlayUrl, false, "")
            GSYVideoType.setShowType(GSYVideoType.SCREEN_MATCH_FULL)
        }

    }

    private fun initVideoView() {
        isInitVideoView = true
        videoView.setVideoAllCallBack(object : EmptyControlVideo.EmptyControlVideoCallBack() {

            override fun onPrepared(url: String?, vararg objects: Any?) {
                Log.d(TAG, "onPrepared")
                imageView.visibility = View.INVISIBLE
            }

            override fun onAutoComplete(url: String?, vararg objects: Any?) {
                //播放完成
                Log.d(TAG, "onAutoComplete")
                imageView.visibility = View.VISIBLE
                videoView.startPlayLogic()
            }

            override fun onPlayError(url: String?, vararg objects: Any?) {
                Log.d(TAG, "onPlayError")
                imageView.visibility = View.VISIBLE
                videoView.startPlayLogic()
            }

        })
    }

    fun play() {
        if (!isInitVideoView && videoView.visibility == View.INVISIBLE) {
            videoView.startPlayLogic()
            initVideoView()
        }
    }

    fun releasePlayer() {
        isInitVideoView = false
        if (videoView.visibility == View.VISIBLE) {
            videoView.setStandardVideoAllCallBack(null)
            GSYVideoPlayer.releaseAllVideos()
        }
    }


}