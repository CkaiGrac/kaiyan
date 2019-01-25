package com.exercise.ckaiself.kaiyan_kotlinver.util;

import android.os.Build;
import android.support.design.widget.TabLayout;
import android.view.View;
import android.widget.LinearLayout;

import java.lang.reflect.Field;

/**
 * @author Ckai
 * @date 2019/1/20 12:02 PM
 * @description
 */
public class ViewUtil {

    public static void setUpIndicatorWidth(TabLayout tabLayout) {
        Class<?> tabLayoutClass = tabLayout.getClass();
        Field tabStrip = null;
        try {

            tabStrip = tabLayoutClass.getDeclaredField("mTabStrip");
            tabStrip.setAccessible(true);

        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }

        LinearLayout layout = null;

        try {

            if (tabStrip != null) {
                layout = (LinearLayout) tabStrip.get(tabLayout);
            }

            for (int i = 0; i < layout.getChildCount(); i++) {
                View child = layout.getChildAt(i);
                child.setPadding(0, 0, 0, 0);
                LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.MATCH_PARENT, 1);
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
                    params.setMarginStart(DisplayManager.INSTANCE.dip2px(50));
                    params.setMarginEnd(DisplayManager.INSTANCE.dip2px(50));
                }
                child.setLayoutParams(params);
                child.invalidate();
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }
}
