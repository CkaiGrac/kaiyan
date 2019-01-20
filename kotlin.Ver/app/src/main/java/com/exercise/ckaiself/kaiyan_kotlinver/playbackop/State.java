package com.exercise.ckaiself.kaiyan_kotlinver.playbackop;

import android.view.MotionEvent;

/**
 * @author Ckai
 * @date 2019/1/11 2:49 PM
 * @description
 */
public class State {

    //事件
    public MotionEvent event;

    //从当前activity开始录制到该事件发生的时间
    public long time;
}
