package com.exercise.ckaiself.kaiyan_kotlinver.mvp.presenter

import android.app.Activity
import com.exercise.ckaiself.kaiyan_kotlinver.dataFormat
import com.exercise.ckaiself.kaiyan_kotlinver.getNetType
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract.DetailContract
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.DetailModel
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.showToast
import com.exercise.ckaiself.kaiyan_kotlinver.util.DisplayManager
import io.reactivex.disposables.Disposable

/**
 * @author Ckai
 * @date 2019/1/20 5:03 PM
 * @description
 */

class DetailPresenter(view: DetailContract.IView) : DetailContract.IPresenter {

    var moreRelatedUrl: String? = ""
    var moreReplyUrl: String? = ""

    val detailView: DetailContract.IView
    val detailModel: DetailModel by lazy {
        DetailModel()
    }

    init {
        detailView = view
    }

    override fun requestBasicDataFromMemory(itemData: Item): Disposable? {
        val url =
            itemData.data?.cover?.blurred + "/thumbnail/${DisplayManager.getScreenHeight()!! - DisplayManager.dip2px(
                250f
            )!!}x${DisplayManager.getScreenWidth()}"
        detailView.setBackground(url)
        val netType = (detailView as Activity).getNetType()
        val playInfo = itemData.data?.playInfo

        playInfo?.let {
            if (netType == 1) {
                //wifi
                //设置播放器
                for (playinfo in playInfo) {
                    if (playinfo.type == "high") {
                        val playUrl = playinfo.url
                        detailView.setPlayer(playUrl)
                        break
                    }
                }
            } else {
                //不是wifi
                for (playinfo in playInfo) {
                    if (playinfo.type == "normal") {
                        val playUrl = playinfo.url
                        detailView.setPlayer(playUrl)
                        (detailView as Activity).showToast("本次播放将消耗${(detailView as Activity).dataFormat(playinfo.urlList[0].size)}流量")
                        break
                    }

                }
            }
        }
        detailView.setMovieAuthorInfo(itemData)
        return requestRelatedData(itemData.data!!.id)
    }

    override fun requestRelatedData(id: Long): Disposable? {
        return detailModel.loadRelatedData(id).subscribe { issue -> detailView.setRelted(issue.itemList) }
    }

    override fun requestRelatedAllList(url: String?, title: String): Disposable? {
        detailView.showDropDownView(title)
        url?.let {
            return detailModel.loadDetailMoreRelatedList(url)
                .subscribe { issue ->
                    moreRelatedUrl = issue.nextPageUrl
                    detailView.setDropDownView(issue)
                }
        }
        return null
    }

    override fun requestRelatedAllMoreList(): Disposable? {
        moreRelatedUrl?.let {
            if (it != "") {
                return detailModel.loadDetailMoreRelatedList(it)
                    .subscribe { issue ->
                        moreRelatedUrl = issue.nextPageUrl
                        detailView.setMoreDropDownView(issue)
                    }
            }
        }
        detailView.setMoreDropDownView(null)
        return null
    }

    override fun requestReply(videoId: Long): Disposable? {
        detailView.showDropDownView("评论")
        return detailModel.loadReplyList(videoId)
            .subscribe { issue ->
                moreRelatedUrl = issue.nextPageUrl
                detailView.setDropDownView(issue)
            }
    }

    override fun requestMoreReply(): Disposable? {
        moreReplyUrl?.let {
            if (it != "") {
                return detailModel.loadMoreReplyList(it)
                    .subscribe { issue ->
                        moreReplyUrl = issue.nextPageUrl
                        detailView.setMoreDropDownView(issue)
                    }
            }
        }
        detailView.setMoreDropDownView(null)
        return null
    }

}
