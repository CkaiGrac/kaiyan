package com.exercise.ckaiself.kaiyan_kotlinver.net

import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Category
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HomeBean
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.HotCategory
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Issue
import io.reactivex.Observable
import retrofit2.http.GET
import retrofit2.http.Query
import retrofit2.http.Url

/**
 * @author Ckai
 * @date 2019/1/11 5:45 PM
 * @description
 */
interface ApiService {

    //"http://baobab.kaiyanapp.com/api/"


    /**
     * banner + 一页数据
     */
    @GET("v2/feed?&num=1")
    fun getFirstHomeData(@Query("date") date: Long): Observable<HomeBean>

    @GET
    fun getMoreHomeData(@Url url: String): Observable<HomeBean>


    /**
     * 获取分类
     */
    @GET("v4/categories")
    fun getCategory(): Observable<ArrayList<Category>>


    /**
     * issue里面包含了itemList和nextPageUrl
     */
    @GET
    fun getIssue(@Url url: String): Observable<Issue>

    /**
     * 获取分类下的全部数据
     * http://baobab.kaiyanapp.com/api/v4/categories/detail/index?id=36
     */
    @GET("v4/categories/detail/index")
    fun getCategoryItemList(@Query("id") id: Long): Observable<Issue>

    /**
     * 热门分类
     */
    @GET
    fun getHotCategory(@Url url: String): Observable<HotCategory>


    /**
     * 根据item id获取相关视频
     */
    @GET("v4/video/related?")
    fun getRelatedData(@Query("id") id: Long): Observable<Issue>

    /**
     * 获取回复
     */
    @GET("v2/replies/video?")
    fun getReply(@Query("videoId") videoId: Long): Observable<Issue>


}