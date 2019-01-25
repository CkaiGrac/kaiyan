package com.exercise.ckaiself.kaiyan_kotlinver.adapter

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.view.DetailInfoItem
import com.exercise.ckaiself.kaiyan_kotlinver.view.DetailTextCardView
import com.exercise.ckaiself.kaiyan_kotlinver.view.DetailVideoCardView
import com.exercise.ckaiself.kaiyan_kotlinver.view.ListEndView
import java.net.URLDecoder

/**
 * @author Ckai
 * @date 2019/1/22 11:46 AM
 * @description
 */

class DetailAdapter : RecyclerView.Adapter<DetailAdapter.ViewHolder>() {

    val TYPE_INFO_CARD = 0
    val TYPE_TEXT_CARD = 1
    val TYPE_VIDEO_CARD = 2
    val TYPE_END_CARD = 3

    val data: ArrayList<Item> by lazy { ArrayList<Item>() }

    //已经播放过jumpshow动画的position集合,只播放一次
    val hasPlayedAnimationList: ArrayList<Int> by lazy { ArrayList<Int>() }

    var onVideoClick: ((Item) -> Unit)? = null

    /**
     * 第一个参数为url
     * 第二个参数为title
     */
    var onCategoryTitleClick: ((String?, String?) -> Unit)? = null

    /**
     * 视频信息、作者信息 点击
     */
    var onMovieAuthorClick: ((Int) -> Unit)? = null

    /**
     * 只有添加影片信息、作者信息这个item会掉这儿，所以需要先清空数据
     * （比如点了相关推荐的其他item，刷新全部数据，包括影片信息，会先调用这个）
     */
    fun addData(item: Item) {
        data.clear()
        notifyDataSetChanged()
        data.add(item)
        notifyDataSetChanged()
    }


    fun addData(itemList: ArrayList<Item>) {
        data.addAll(itemList)
        notifyItemRangeInserted(1, itemList.size)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        var itemView: View
        when (viewType) {
            TYPE_TEXT_CARD -> {
                itemView = DetailTextCardView(parent?.context)
            }
            TYPE_VIDEO_CARD -> {
                itemView = DetailVideoCardView(parent?.context)
            }
            TYPE_INFO_CARD -> {
                itemView = DetailInfoItem(parent?.context)
            }
            TYPE_END_CARD -> {
                itemView = ListEndView(parent?.context)
                itemView.layoutParams = RecyclerView.LayoutParams(RecyclerView.LayoutParams.MATCH_PARENT, RecyclerView.LayoutParams.WRAP_CONTENT)
            }
            else -> {
                throw  IllegalArgumentException("api错误")
            }
        }
        return ViewHolder(itemView)
    }

    override fun getItemCount(): Int = data.size + 1

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val itemView = holder?.itemView
        when (getItemViewType(position)) {

            TYPE_TEXT_CARD -> {
                (itemView as DetailTextCardView).setText(data[position])
                itemView.setOnClickListener {
                    onCategoryTitleClick?.invoke(URLDecoder
                            .decode(data[position].data?.actionUrl
                                    ?.split("&url=")!![1],
                                    "utf-8"), data[position].data?.text)
                }
            }

            TYPE_VIDEO_CARD -> {
                val hasPlay = hasPlayedAnimationList.contains(position)
                if (!hasPlay) {
                    hasPlayedAnimationList.add(position)
                }
                (itemView as DetailVideoCardView).setData(data[position], !hasPlay)
                itemView.setOnClickListener {
                    onVideoClick?.invoke(data[position])
                }
            }

            TYPE_INFO_CARD -> {
                val hasPlay = hasPlayedAnimationList.contains(position)
                if (!hasPlay) {
                    hasPlayedAnimationList.add(position)
                }
                (itemView as DetailInfoItem).let {
                    it.setData(data[position], !hasPlay)
                    it.onMovieAuthorClick = onMovieAuthorClick
                }
            }

            TYPE_END_CARD -> {
                (itemView as ListEndView).setShow(data.size > 1)
            }

            else -> {
                throw IllegalArgumentException("api出错")
            }

        }
    }

    override fun getItemViewType(position: Int): Int {
        if (position == 0) {
            return TYPE_INFO_CARD
        } else if (position == itemCount - 1) {
            return TYPE_END_CARD
        } else {
            if (data[position].type == "textCard") {
                return TYPE_TEXT_CARD
            } else if (data[position].type == "videoSmallCard") {
                return TYPE_VIDEO_CARD
            }
        }
        throw IllegalArgumentException("api出错")
    }

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)


    fun setOnItemClick(onVideoClick: (Item) -> Unit = {},
                       onCategoryTitleClick: (String?, String?) -> Unit = { _, _ -> },
                       onMovieAuthorClick: (Int) -> Unit) {
        this.onVideoClick = onVideoClick
        this.onCategoryTitleClick = onCategoryTitleClick
        this.onMovieAuthorClick = onMovieAuthorClick
    }
}