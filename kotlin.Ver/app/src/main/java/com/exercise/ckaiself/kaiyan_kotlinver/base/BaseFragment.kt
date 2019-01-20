package com.exercise.ckaiself.kaiyan_kotlinver.base

import android.support.v4.app.Fragment
import com.exercise.ckaiself.kaiyan_kotlinver.R
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.disposables.Disposable

/**
 * @author Ckai
 * @date 2019/1/11 4:26 PM
 * @description
 */

var currentFragment = R.id.rb_home
val tabsId = listOf(R.id.rb_home, R.id.rb_category, R.id.rb_hot)

abstract class BaseFragment(tabId: Int) : Fragment(), RxNetManager {
    var tabId = 0

    init {
        this.tabId = tabId
    }

    protected val disposables = CompositeDisposable()

    override fun onDestroyView() {
        super.onDestroyView()
        disposables.clear()
    }

    override fun dispose(disposable: Disposable) {
        disposables.remove(disposable)
    }

    override fun addDisposable(disposable: Disposable) {
        disposables.add(disposable)
    }

    open fun setupToolbar(): Boolean {
        if (tabId != currentFragment) {
            return true
        }
        return false
    }

}