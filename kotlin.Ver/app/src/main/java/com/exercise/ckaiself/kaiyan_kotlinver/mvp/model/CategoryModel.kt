package com.exercise.ckaiself.kaiyan_kotlinver.mvp.model

import com.exercise.ckaiself.kaiyan_kotlinver.io_main
import com.exercise.ckaiself.kaiyan_kotlinver.mvp.model.bean.Category
import com.exercise.ckaiself.kaiyan_kotlinver.net.Network
import io.reactivex.Observable

/**
 * @author Ckai
 * @date 2019/1/11 5:29 PM
 * @description
 */

class CategoryModel {

    fun loadData(): Observable<ArrayList<Category>> {
        return Network.service.getCategory().io_main()
    }

}