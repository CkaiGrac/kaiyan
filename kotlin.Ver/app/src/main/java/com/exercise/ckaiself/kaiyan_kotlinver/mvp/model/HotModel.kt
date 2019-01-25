package com.exercise.ckaiself.kaiyan_kotlinver.mvp.model

import com.exercise.ckaiself.kaiyan_kotlinver.io_main
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HotCategory
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Issue
import com.exercise.ckaiself.kaiyan_kotlinver.net.Network
import io.reactivex.Observable

/**
 * @author Ckai
 * @date 2019/1/20 11:16 AM
 * @description
 */

class HotModel {

    /**
     * 日排行，周排行等详细数据请求
     */
    fun loadListData(url: String): Observable<Issue> {
        return Network.service.getIssue(url).io_main()
    }

    /**
     * fragment的总数据，包括 日排行，周排行等api
     */
    fun loadCategoryData(url: String): Observable<HotCategory> {
        return Network.service.getHotCategory(url).io_main()
    }
}