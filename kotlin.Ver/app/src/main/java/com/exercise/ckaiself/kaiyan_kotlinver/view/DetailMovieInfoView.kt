package com.exercise.ckaiself.kaiyan_kotlinver.view

import android.content.Context
import android.graphics.Color
import android.util.AttributeSet
import android.view.View
import android.widget.LinearLayout
import com.exercise.ckaiself.kaiyan_kotlinver.R
import kotlinx.android.synthetic.main.layout_detail_movie_info.view.*


/**
 * @author Ckai
 * @date 2019/1/22 2:01 PM
 * @description
 */

class DetailMovieInfoView : LinearLayout {

    var onMovieClick: ((Int) -> Unit)? = null

    constructor(context: Context?) : this(context, null)
    constructor(context: Context?, attrs: AttributeSet?) : this(context, attrs, 0)
    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr) {
        init()
        initListener()

    }

    private fun init() {
        View.inflate(context, R.layout.layout_detail_movie_info, this)
        this.tv_title.isBold = true
        this.tv_title.color = Color.WHITE
        this.tv_title.textSize = 40f

        this.tv_intro.color = Color.WHITE

        this.tv_tag.color = 0xeeffffff.toInt()
        this.tv_tag.textSize = 35f

        this.tv_intro.color = 0xeeffffff.toInt()
        this.tv_intro.textSize = 35f

    }

    private fun initListener() {
        tv_favorites.setOnClickListener { onMovieClick?.invoke(BTN_FAVORITES) }
        tv_share.setOnClickListener { onMovieClick?.invoke(BTN_SHARE) }
        tv_reply.setOnClickListener { onMovieClick?.invoke(BTN_REPLY) }
        tv_download.setOnClickListener { onMovieClick?.invoke(BTN_DOWLOAD) }
    }

    fun setTitle(title: String?, playAnimation: Boolean) {
        this.tv_title.withAnimation = playAnimation
        this.tv_title.text = title
    }

    fun setTag(tag: String?, playAnimation: Boolean) {
        this.tv_tag.withAnimation = playAnimation
        this.tv_tag.text = tag
    }

    fun setIntro(intro: String?, playAnimation: Boolean) {
        this.tv_intro.withAnimation = playAnimation
        this.tv_intro.text = intro
    }

    fun setFavorites(favorites: Int?) {
        this.tv_favorites.text = favorites.toString()
    }

    fun setShare(share: Int?) {
        this.tv_share.text = share.toString()
    }

    fun setReply(reply: Int?) {
        this.tv_reply.text = reply.toString()
    }
}