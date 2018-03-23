package com.talkingdata.demo;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.tendcloud.tenddata.TCAgent;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = MainActivity.class.getSimpleName();
    static Context context;

    private WebView mWebView;

    @SuppressLint("SetJavaScriptEnabled")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        context = getApplicationContext();

        mWebView = findViewById(R.id.webview);
        mWebView.getSettings().setJavaScriptEnabled(true);
        mWebView.loadUrl("https://talkingdata.github.io/HybridAssets/index.html");
        mWebView.setWebViewClient(new MyWebviewClient());
    }

    class MyWebviewClient extends WebViewClient {

        @Override
        public void onPageFinished(WebView view, String url)
        {
            view.loadUrl("javascript:setWebViewFlag()");
            TCAgent.onPageStart(MainActivity.context, url);
        }

        @TargetApi(Build.VERSION_CODES.LOLLIPOP)
        @Override
        public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
            String url = request.getUrl().toString();

            Log.d(TAG, "shouldOverrideUrlLoading: url->" + url);

            try {
                String decodedURL = java.net.URLDecoder.decode(url, "UTF-8");
                TalkingDataHTML.GetInstance().execute(MainActivity.this, decodedURL, view);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }
    }
}
