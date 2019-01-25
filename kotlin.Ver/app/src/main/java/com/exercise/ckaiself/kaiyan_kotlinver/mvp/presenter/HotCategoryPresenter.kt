package com.exercise.ckaiself.kaiyan_kotlinver.mvp.presenter

import android.annotation.SuppressLint
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract.HotContract
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.HotModel

/**
 * @author Ckai
 * @date 2019/1/20 11:42 AM
 * @description
 */

class HotCategoryPresenter(view: HotContract.IHotCategoryView) : HotContract.IHotCategoryPresenter {

    val hotCategoryView: HotContract.IHotCategoryView

    init {
        hotCategoryView = view
    }

    val hotModel: HotModel by lazy {
        HotModel()
    }

    @SuppressLint("CheckResult")
    override fun requestData(url: String) {
        hotModel.loadListData(url)
            .subscribe({ issue ->
                hotCategoryView.setLIstData(issue.itemList)
            }, {
                it.printStackTrace()
                hotCategoryView.onCategoryError()
            })

    }


}