package com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract

import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BasePresenter
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BaseView
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Issue
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import io.reactivex.disposables.Disposable

/**
 * @author Ckai
 * @date 2019/1/20 4:41 PM
 * @description
 */
interface DetailContract {

    interface IView : BaseView<IPresenter> {

        /**
         * 设置播放器
         */
        fun setPlayer(playUrl: String)

        /**
         * 设置影片信息/作者
         */
        fun setMovieAuthorInfo(info: Item)

        /**
         * 设置相关视频
         */
        fun setRelted(itemList: ArrayList<Item>)

        /**
         * 设置背景，高斯模糊什么的
         */
        fun setBackground(url: String)

        /**
         * 显示相关推荐之类的全部的view
         */
        fun showDropDownView(title: String)

        /**
         * 设置相关推荐之类的全部的view的数据
         */
        fun setDropDownView(issue: Issue)

        /**
         * 设置相关推荐之类的全部的view的数据(底部加载更多)
         */
        fun setMoreDropDownView(issue: Issue?)


    }


    interface IPresenter : BasePresenter {

        /**
         * 请求相关视频
         */
        fun requestRelatedData(id: Long): Disposable?

        /**
         * 从内存中获取基础数据（影片信息、作者等）
         */
        fun requestBasicDataFromMemory(itemData: Item): Disposable?

        /**
         * 请求相关推荐的数据
         */
        fun requestRelatedAllList(url: String?, title: String): Disposable?

        /**
         * 请求相关推荐的更多数据
         */
        fun requestRelatedAllMoreList(): Disposable?

        /**
         * 请求评论数据
         */
        fun requestReply(videoId: Long): Disposable?

        /**
         * 请求更多评论数据
         */
        fun requestMoreReply(): Disposable?
    }
}