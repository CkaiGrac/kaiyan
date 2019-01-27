package com.exercise.ckaiself.kaiyan_kotlinver.mvp.presenter

import android.annotation.SuppressLint
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract.HomeContract
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.HomeModel
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HomeBean

/**
 * @author Ckai
 * @date 2019/1/16 3:52 PM
 * @description
 */

class HomePresenter(view: HomeContract.IView) : HomeContract.IPresenter {

    val homeView: HomeContract.IView
    var nextPageUrl: String? = null
    val homeModel: HomeModel by lazy {
        HomeModel()
    }

    var bannerHomeBean: HomeBean? = null

    init {
        homeView = view
    }


    @SuppressLint("CheckResult")
    override fun requestFirstData() {
        homeModel.loadFirstData()
            .flatMap { homeBean ->
                bannerHomeBean = homeBean
                homeModel.loadMoreData(homeBean.nextPageUrl)
            }
            .subscribe({ homeBean ->
                nextPageUrl = homeBean.nextPageUrl
                //这里记录轮播图的长度，在Adapter中使用
                bannerHomeBean!!.issueList[0].count = bannerHomeBean!!.issueList[0].itemList.size

                //过滤掉banner2的内容
                val newItemList = homeBean.issueList[0].itemList
                newItemList.filter { item -> item.type == "banner2" }.forEach { item -> newItemList.remove(item) }

                bannerHomeBean?.issueList!![0].itemList.addAll(newItemList)
                homeView.setFirstData(bannerHomeBean!!)
            }, { t ->
                t.printStackTrace()
                homeView.onError()
            })
    }

    override fun requestMoreData() {
        nextPageUrl?.let {
            homeModel.loadMoreData(it)
                .subscribe({ homeBean ->

                    //过滤掉banner2的内容
                    val newItemList = homeBean.issueList[0].itemList
                    newItemList.filter { item -> item.type == "banner2" }.forEach { item -> newItemList.remove(item) }
                    homeView.setMoredata(newItemList)
                    nextPageUrl = homeBean.nextPageUrl
                })
        }
    }


}