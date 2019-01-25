package com.exercise.ckaiself.kaiyan_kotlinver.fragment

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.exercise.ckaiself.kaiyan_kotlinver.R
import com.exercise.ckaiself.kaiyan_kotlinver.adapter.HotViewPagerAdapter
import com.exercise.ckaiself.kaiyan_kotlinver.base.BaseFragment
import com.exercise.ckaiself.kaiyan_kotlinver.base.tabsId
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.contract.HotContract
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HotCategory
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.presenter.HotFragmentPresenter
import com.exercise.ckaiself.kaiyan_kotlinver.showToast
import com.exercise.ckaiself.kaiyan_kotlinver.util.ViewUtil
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.fragment_hot.*

/**
 * @author Ckai
 * @date 2019/1/11 4:42 PM
 * @description
 */

class HotFragment : BaseFragment(tabId = tabsId[2]), HotContract.IHotFragmentView {

    val presenter: HotFragmentPresenter
    var isFirst = true

    init {
        presenter = HotFragmentPresenter(this)
    }


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater?.inflate(R.layout.fragment_hot, null)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        presenter.requsetHotCategory()
    }

    override fun setupToolbar(): Boolean {
        if (super.setupToolbar()) {
            return true
        }
        super.setupToolbar()
        activity?.toolbar?.setBackgroundColor(0xddffffff.toInt())
        activity?.iv_search?.setImageResource(R.mipmap.ic_action_search)
        activity?.tv_bar_title?.text = "热门"
        return true
    }


    override fun onResume() {
        super.onResume()
        if (isFirst) {
            setupToolbar()
            isFirst = false
        }
    }

    override fun setTabAndFragment(hotCategory: HotCategory) {
        val titleList = ArrayList<String>()
        for (tab in hotCategory.tabInfo.tabList) {
            titleList.add(tab.name)
        }
        val fragmentList = ArrayList<Fragment>()
        for (tab in hotCategory.tabInfo.tabList) {
            fragmentList.add(HotDetailFragment(tab.apiUrl))
        }
        val hotViewPagerAdapter = HotViewPagerAdapter(fragmentManager!!, titleList, fragmentList)
        vpMain.adapter = hotViewPagerAdapter
        tabLayout.setupWithViewPager(vpMain)

        //ViewUtil.setUpIndicatorWidth(tabLayout)

    }

    override fun onFragmentError() {
        showToast("Fragment网络错误")
    }

}