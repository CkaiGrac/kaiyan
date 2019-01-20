package com.exercise.ckaiself.kaiyan_kotlinver.playbackop;

import java.util.LinkedList;
import java.util.Queue;

/**
 * @author Ckai
 * @date 2019/1/11 2:55 PM
 * @description 以队列的形式存储MotionEvent，以Activity为单位
 */
public class OPState {

    //存储元素为一个队列，存放一个activity中的操作状态
    public static Queue<Queue<State>> states = new LinkedList<>();

    //是否在录制
    public static boolean isRecord = false;

    public static boolean play = false;

}
