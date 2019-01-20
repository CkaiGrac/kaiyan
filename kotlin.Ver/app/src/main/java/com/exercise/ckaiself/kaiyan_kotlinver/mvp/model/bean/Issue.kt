package com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean

import java.io.Serializable


/**
 * @author Ckai
 * @date 2019/1/15 11:19 AM
 * @description
 */

data class Issue(
    val itemList: ArrayList<Item>,
    var count: Int,
    val total: Int,
    val nextPageUrl: String,
    val adExist: Boolean
)