package com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract

import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BasePresenter
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.base.BaseView
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HotCategory
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item

/**
 * @author Ckai
 * @date 2019/1/20 11:23 AM
 * @description 热门的契约接口，统一管理view和presenter中的接口，使得二者的功能一目了然
 */
interface HotContract {

    /**
     * fragment 请求总数据
     */
    interface IHotFragmentPresenter : BasePresenter {
        fun requsetHotCategory()
    }

    /**
     * 根据总数据里面的api进一步请求数据
     */
    interface IHotCategoryPresenter : BasePresenter {
        fun requestData(url: String)
    }

    interface IHotFragmentView : BaseView<IHotFragmentView> {
        fun setTabAndFragment(hotCategory: HotCategory)
        fun onFragmentError()
    }

    interface IHotCategoryView : BaseView<IHotCategoryPresenter> {
        fun setLIstData(itemList: ArrayList<Item>)
        fun onCategoryError()
    }


}