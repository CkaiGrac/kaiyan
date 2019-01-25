package com.exercise.ckaiself.kaiyan_kotlinver.mvp.model

import com.exercise.ckaiself.kaiyan_kotlinver.io_main
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Issue
import com.exercise.ckaiself.kaiyan_kotlinver.net.Network
import io.reactivex.Observable

/**
 * @author Ckai
 * @date 2019/1/20 4:30 PM
 * @description 详情页Model，请求默认精选（无date参数是banner，每次加载更多，加载一条带date）
 */

class DetailModel {


    fun loadRelatedData(id: Long): Observable<Issue> {
        return Network.service.getRelatedData(id).io_main()
    }

    fun loadDetailMoreRelatedList(url: String): Observable<Issue> {
        return Network.service.getIssue(url).io_main()
    }

    fun loadReplyList(videoId: Long): Observable<Issue> {
        return Network.service.getReply(videoId).io_main()
    }

    fun loadMoreReplyList(url: String): Observable<Issue> {
        return Network.service.getIssue(url).io_main()
    }

}