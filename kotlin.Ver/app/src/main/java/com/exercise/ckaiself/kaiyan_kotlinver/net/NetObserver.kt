package com.exercise.ckaiself.kaiyan_kotlinver.net

import com.exercise.ckaiself.kaiyan_kotlinver.base.BaseActivity
import com.exercise.ckaiself.kaiyan_kotlinver.base.BaseFragment
import io.reactivex.observers.DisposableObserver

/**
 * @author Ckai
 * @date 2019/1/11 5:52 PM
 * @description
 */

class NetObserber<T> : DisposableObserver<T> {

    var activity: BaseActivity? = null
    var fragment: BaseFragment? = null
    var onSuccess: OnSuccess? = null

    constructor(activity: BaseActivity?, onSuccess: OnSuccess) : super() {
        this.activity = activity
        this.onSuccess = onSuccess
    }

    constructor(fragment: BaseFragment?, onSuccess: OnSuccess) : super() {
        this.fragment = fragment
        this.onSuccess = onSuccess
    }


    override fun onComplete() {
        activity?.dispose(this)
        fragment?.dispose(this)
    }

    override fun onNext(t: T) {
        onSuccess?.OnSuccess()
    }

    override fun onError(e: Throwable) {
        e.printStackTrace()

        activity?.dispose(this)
        fragment?.dispose(this)
    }


    interface OnSuccess {
        fun OnSuccess()
    }


    override fun onStart() {
        super.onStart()
        activity?.addDisposable(this)
        fragment?.addDisposable(this)
    }


}
