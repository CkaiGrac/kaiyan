package com.exercise.ckaiself.kaiyan_kotlinver.mvp.model

import com.exercise.ckaiself.kaiyan_kotlinver.io_main
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Issue
import com.exercise.ckaiself.kaiyan_kotlinver.net.Network
import io.reactivex.Observable

/**
 * @author Ckai
 * @date 2019/1/15 11:18 AM
 * @description
 */

class CategoryDetailModel {

    fun loadData(id: Long): Observable<Issue> {
        return Network.service.getCategoryItemList(id).io_main()
    }

    fun loadMoreData(url: String): Observable<Issue> {
        return Network.service.getIssue(url).io_main()
    }
}