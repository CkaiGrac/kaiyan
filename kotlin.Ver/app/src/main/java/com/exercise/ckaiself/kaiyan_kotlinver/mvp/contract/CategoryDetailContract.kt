package com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract

import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BasePresenter
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BaseView
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Category
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item

/**
 * @author Ckai
 * @date 2019/1/15 1:38 PM
 * @description 分类详情的契约接口，统一管理view和presenter中的接口，使得二者的功能一目了然
 */
interface CategoryDetailContract {

    interface IPresenter : BasePresenter {
        fun requestMoreData()

        fun start(category: Category)
    }

    interface IView : BaseView<IPresenter> {
        fun setHeader(category: Category)
        fun setListData(itemList: ArrayList<Item>)
        fun onError()
    }
}