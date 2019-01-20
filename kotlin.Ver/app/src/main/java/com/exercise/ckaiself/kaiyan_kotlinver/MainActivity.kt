package com.exercise.ckaiself.kaiyan_kotlinver

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.View
import android.widget.Toast
import com.exercise.ckaiself.kaiyan_kotlinver.base.BaseActivity
import com.exercise.ckaiself.kaiyan_kotlinver.base.BaseFragment
import com.exercise.ckaiself.kaiyan_kotlinver.base.currentFragment
import com.exercise.ckaiself.kaiyan_kotlinver.base.tabsId
import com.exercise.ckaiself.kaiyan_kotlinver.fragment.CategoryFragment
import com.exercise.ckaiself.kaiyan_kotlinver.fragment.HomeFragment
import com.exercise.ckaiself.kaiyan_kotlinver.fragment.HotFragment
import com.exercise.ckaiself.kaiyan_kotlinver.playbackop.OPState
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setRadio()
    }


    private fun setRadio() {
        rb_home.isChecked = true
        chooseFragment(R.id.rb_home)
        rg_root.setOnCheckedChangeListener { _, checkId -> chooseFragment(checkId) }
    }

    private fun chooseFragment(checkedId: Int) {
        currentFragment = checkedId

        val beginTransaction = supportFragmentManager.beginTransaction()

        val fragment: Fragment? = supportFragmentManager.findFragmentByTag(checkedId.toString())
        if (fragment == null) {
            when (checkedId) {
                R.id.rb_home -> beginTransaction.add(R.id.fl_content, HomeFragment(), checkedId.toString())
                R.id.rb_hot -> beginTransaction.add(R.id.fl_content, HotFragment(), checkedId.toString())
                R.id.rb_category -> beginTransaction.add(R.id.fl_content, CategoryFragment(), checkedId.toString())
            }
        }

        tabsId.forEach { tab ->
            val aFragment = supportFragmentManager.findFragmentByTag(tab.toString()) as BaseFragment?
            if (tab == checkedId) {
                aFragment?.let {
                    aFragment.setupToolbar()
                    beginTransaction.show(it)
                }
            } else {
                aFragment?.let {
                    beginTransaction.hide(it)
                }
            }
        }

        beginTransaction.commit()

    }

    fun record(view: View) {
        OPState.isRecord = true
        Toast.makeText(this, "开始录制", Toast.LENGTH_SHORT).show()
        record()
    }

    fun play(view: View) {
        OPState.play = true
        Toast.makeText(this, "开始播放", Toast.LENGTH_SHORT).show()
    }

}
