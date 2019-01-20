package com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean

import java.io.Serializable

/**
 * @author Ckai
 * @date 2019/1/11 5:15 PM
 * @description
 */

data class Category(
        val id: Long,

        val name: String,

        val description: String,

        val bgPicture: String,

        val bgColor: String,

        val headerImage: String
) : Serializable
