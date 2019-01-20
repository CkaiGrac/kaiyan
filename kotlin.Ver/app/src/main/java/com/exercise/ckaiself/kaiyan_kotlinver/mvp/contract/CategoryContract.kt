package com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract

import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BasePresenter
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BaseView
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Category

/**
 * @author Ckai
 * @date 2019/1/11 5:19 PM
 * @description 分类的契约接口，统一管理view和presenter中的接口，使得二者的功能一目了然
 */
interface CategoryContract {

    interface IView : BaseView<IPresenter> {
        fun showCategory(category: ArrayList<Category>)
        fun onError()
    }

    interface IPresenter : BasePresenter {
        fun requestData()
    }
}