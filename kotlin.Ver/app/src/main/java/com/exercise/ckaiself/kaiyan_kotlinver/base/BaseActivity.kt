package com.exercise.ckaiself.kaiyan_kotlinver.base

import android.os.Handler
import android.support.v7.app.AppCompatActivity
import android.view.MotionEvent
import com.exercise.ckaiself.kaiyan_kotlinver.playbackop.OPState
import com.exercise.ckaiself.kaiyan_kotlinver.playbackop.State
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.disposables.Disposable
import java.util.*


abstract class BaseActivity : AppCompatActivity(), RxNetManager {
    protected val disposables = CompositeDisposable()
    internal var handler = Handler()

    //存放在当前activity中的事件
    private var activityEvents: Queue<State>? = null

    //当前activity可见之后的时间点
    //每次onResume之后都创建一个行的队列，同时也赋值行的stateTime
    private var startTime: Long = 0

    override fun onResume() {
        super.onResume()
    }


    override fun onBackPressed() {
        val state = State()
        state.event = null
        state.time = System.currentTimeMillis() - startTime
        activityEvents?.add(state)
        super.onBackPressed()
    }

    override fun dispatchTouchEvent(ev: MotionEvent?): Boolean {
        if (OPState.isRecord && activityEvents != null) {
            val obtain = MotionEvent.obtain(ev)
            val state = State()
            state.event = obtain
            state.time - System.currentTimeMillis() - startTime
            activityEvents?.add(state)
        }
        return super.dispatchTouchEvent(ev)
    }

    override fun onDestroy() {
        super.onDestroy()
        disposables.clear()
    }

    override fun dispose(disposable: Disposable) {
        disposables.remove(disposable)
    }

    override fun addDisposable(disposable: Disposable) {
        disposables.add(disposable)
    }

}
