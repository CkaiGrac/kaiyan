package com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean

/**
 * @author Ckai
 * @date 2019/1/16 3:35 PM
 * @description
 */

data class HomeBean(
    var issueList: ArrayList<Issue>,
    val nextPageUrl: String,
    val nextPublishTime: Long,
    val newestIssueType: String,
    val dialog: Any
)