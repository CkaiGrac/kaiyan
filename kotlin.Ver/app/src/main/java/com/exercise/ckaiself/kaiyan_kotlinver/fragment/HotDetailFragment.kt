package com.exercise.ckaiself.kaiyan_kotlinver.fragment

import android.annotation.SuppressLint
import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.exercise.ckaiself.kaiyan_kotlinver.adapter.HotCategoryAdapter
import com.exercise.ckaiself.kaiyan_kotlinver.base.BaseFragment
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract.HotContract
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Item
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.presenter.HotCategoryPresenter
import com.exercise.ckaiself.kaiyan_kotlinver.showToast

/**
 * @author Ckai
 * @date 2019/1/20 2:40 PM
 * @description
 */

class HotDetailFragment : BaseFragment, HotContract.IHotCategoryView {

    var apiUrl = ""
    lateinit var presenter: HotCategoryPresenter
    val adapter by lazy { HotCategoryAdapter() }

    constructor() : super(-1)

    @SuppressLint("ValidFragment")
    constructor(apiUrl: String) : this() {
        this.apiUrl = apiUrl
        presenter = HotCategoryPresenter(this)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val recyclerView = RecyclerView(container!!.context)
        recyclerView.layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
        recyclerView.layoutManager = LinearLayoutManager(container.context)
        recyclerView.adapter = adapter
        recyclerView.overScrollMode = RecyclerView.OVER_SCROLL_NEVER
        return recyclerView
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        presenter.requestData(apiUrl)
    }


    override fun setLIstData(itemList: ArrayList<Item>) {
        adapter.addItemList(itemList)
    }

    override fun onCategoryError() {
        showToast("Category网络错误")
    }


}