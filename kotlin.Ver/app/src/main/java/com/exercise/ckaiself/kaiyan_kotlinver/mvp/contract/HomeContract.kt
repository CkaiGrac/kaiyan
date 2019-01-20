package com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract

import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BasePresenter
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BaseView
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HomeBean
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item

/**
 * @author Ckai
 * @date 2019/1/16 3:47 PM
 * @description 首页的契约接口，统一管理view和presenter中的接口，使得二者的功能一目了然
 */

interface HomeContract {

    interface IPresenter : BasePresenter {

        //刷新数据，第一次
        fun requestFirstData()

        //底部加载更多数据
        fun requestMoreData()
    }

    interface IView : BaseView<IPresenter> {

        fun setFirstData(homeBean: HomeBean)
        fun setMoredata(itemList: ArrayList<Item>)
        fun onError()

    }

}