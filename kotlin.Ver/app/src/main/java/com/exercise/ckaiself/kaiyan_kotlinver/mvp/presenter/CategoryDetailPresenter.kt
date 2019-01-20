package com.exercise.ckaiself.kaiyan_kotlinver.mvp.presenter

import android.annotation.SuppressLint
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract.CategoryDetailContract
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.CategoryDetailModel
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Category

/**
 * @author Ckai
 * @date 2019/1/15 1:47 PM
 * @description
 */

class CategoryDetailPresenter(view: CategoryDetailContract.IView) : CategoryDetailContract.IPresenter {

    val categoryDetailView: CategoryDetailContract.IView
    var nexpageUrl = ""

    val categoryDetailModel: CategoryDetailModel by lazy {
        CategoryDetailModel()
    }

    init {
        categoryDetailView = view
    }


    override fun requestMoreData() {
        categoryDetailModel.loadMoreData(nexpageUrl)
            .subscribe({ issue ->
                nexpageUrl = issue.nextPageUrl
                categoryDetailView.setListData(issue.itemList)
            }, {
                it.printStackTrace()
                categoryDetailView.onError()
            })
    }


    override fun start(category: Category) {
        categoryDetailView.setHeader(category)
        categoryDetailModel.loadData(category.id)
            .subscribe({ issue ->
                nexpageUrl = issue.nextPageUrl
                categoryDetailView.setListData(issue.itemList)
            }, {
                it.printStackTrace()
                categoryDetailView.onError()
            })
    }


}