package com.exercise.ckaiself.kaiyan_kotlinver.mvp.presenter

import com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract.CategoryContract
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.CategoryModel

/**
 * @author Ckai
 * @date 2019/1/11 5:25 PM
 * @description
 */

class CategoryPresenter(view: CategoryContract.IView) : CategoryContract.IPresenter {

    val categoryView: CategoryContract.IView
    val categoryModel: CategoryModel by lazy {
        CategoryModel()
    }

    init {
        categoryView = view
    }

    override fun requestData() {
        categoryModel.loadData()
            .subscribe({ categoryView.showCategory(it) }, {
                it.printStackTrace()
                categoryView.onError()
            })
    }


}