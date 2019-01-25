package com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean

/**
 * @author Ckai
 * @date 2019/1/20 11:18 AM
 * @description
 */
data class HotCategory(val tabInfo: TabInfo) {

    data class TabInfo(val tabList: ArrayList<Tab>)

    data class Tab(val id: Long, val name: String, val apiUrl: String)

}