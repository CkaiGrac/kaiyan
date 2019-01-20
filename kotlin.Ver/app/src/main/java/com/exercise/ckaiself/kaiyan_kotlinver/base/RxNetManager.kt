package com.exercise.ckaiself.kaiyan_kotlinver.base

import io.reactivex.disposables.Disposable

/**
 * @author Ckai
 * @date 2019/1/11 2:40 PM
 * @description
 */
interface RxNetManager {
    fun dispose(disposable: Disposable)
    fun addDisposable(disposable: Disposable)
}