package com.exercise.ckaiself.kaiyan_kotlinver.mvp.presenter

import android.annotation.SuppressLint
import android.util.Log
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract.HotContract
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.HotModel

/**
 * @author Ckai
 * @date 2019/1/20 11:31 AM
 * @description
 */

class HotFragmentPresenter(view: HotContract.IHotFragmentView) : HotContract.IHotFragmentPresenter {

    val hotFragmentView: HotContract.IHotFragmentView

    init {
        hotFragmentView = view
    }

    val hotModel: HotModel by lazy {
        HotModel()
    }

    @SuppressLint("CheckResult")
    override fun requsetHotCategory() {
        hotModel.loadCategoryData("http://baobab.kaiyanapp.com/api/v4/rankList")
            .subscribe({ hotCategory ->
                Log.i("HotFragmentPresenter", "requestHotCategory-->$hotCategory")
                hotFragmentView.setTabAndFragment(hotCategory)
            }, {
                it.printStackTrace()
                hotFragmentView.onFragmentError()
            })
    }



}