package com.talkingdata.demo;

import android.app.Application;

import com.tendcloud.tenddata.TCAgent;

/**
 * 作者：xiaofei
 * 日期：2018/3/21
 */

public class App extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        TCAgent.init(this, "DE40FB8A722D454B8981E2F842E6AAB6", "TalkingData");
    }
}
