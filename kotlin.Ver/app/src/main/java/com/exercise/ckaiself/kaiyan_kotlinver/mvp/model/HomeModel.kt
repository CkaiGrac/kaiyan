package com.exercise.ckaiself.kaiyan_kotlinver.mvp.model

import com.exercise.ckaiself.kaiyan_kotlinver.io_main
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HomeBean
import com.exercise.ckaiself.kaiyan_kotlinver.net.Network
import io.reactivex.Observable


/**
 * @author Ckai
 * @date 2019/1/16 3:40 PM
 * @description
 */

class HomeModel {

    fun loadFirstData(): Observable<HomeBean> {
        return Network.service.getFirstHomeData(System.currentTimeMillis()).io_main()
    }

    fun loadMoreData(url: String): Observable<HomeBean> {
        return Network.service.getMoreHomeData(url).io_main()
    }


}