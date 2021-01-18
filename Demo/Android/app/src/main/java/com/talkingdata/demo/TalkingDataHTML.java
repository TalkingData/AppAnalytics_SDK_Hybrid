package com.talkingdata.demo;

import android.app.Activity;
import android.webkit.WebView;

import com.tendcloud.tenddata.Order;
import com.tendcloud.tenddata.ShoppingCart;
import com.tendcloud.tenddata.TCAgent;
import com.tendcloud.tenddata.TDProfile;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class TalkingDataHTML {
    private static volatile TalkingDataHTML talkingDataHTML = null;
    
    public static TalkingDataHTML GetInstance() {
        if (talkingDataHTML == null) {
            synchronized (TalkingDataHTML.class) {
                if (talkingDataHTML == null) {
                    talkingDataHTML = new TalkingDataHTML();
                }
            }
        }
        return talkingDataHTML;
    }
    
    Activity activity = null;
    String currPageName = null;
    
    public void execute(final Activity activity, final String url, final WebView webView) throws Exception {
        if (url.startsWith("talkingdata")) {
            talkingDataHTML.activity = activity;
            String str = url.substring(12);
            JSONObject jsonObj = new JSONObject(str);
            String functionName = jsonObj.getString("functionName");
            JSONArray args = jsonObj.getJSONArray("arguments");
            if (functionName.equals("getDeviceId")) {
                talkingDataHTML.getDeviceId(args, webView);
            }else if(functionName.equals("getOAID")){
                talkingDataHTML.getOAID(args, webView);
            } else {
                Class<TalkingDataHTML> classType = TalkingDataHTML.class;
                Method method = classType.getDeclaredMethod(functionName, JSONArray.class);
                method.invoke(talkingDataHTML, args);
            }
        }
    }
    
    private void getDeviceId(final JSONArray args, final WebView webView) throws JSONException {
        String deviceId = TCAgent.getDeviceId(MainActivity.context);
        String callBack = args.getString(0);
        webView.loadUrl("javascript:" + callBack + "('" + deviceId + "')");
    }
    private void getOAID(final JSONArray args, final WebView webView) throws JSONException {
        String oaid = TCAgent.getOAID(MainActivity.context);
        String callBack = args.getString(0);
        webView.loadUrl("javascript:" + callBack + "('" + oaid + "')");
    }
    
    @SuppressWarnings("unused")
    private void onRegister(final JSONArray args) throws JSONException {
        String profileId = args.getString(0);
        TDProfile.ProfileType type = this.intToProfileType(args.getInt(1));
        String name = args.getString(2);
        TCAgent.onRegister(profileId, type, name);
    }
    
    @SuppressWarnings("unused")
    private void onLogin(final JSONArray args) throws JSONException {
        String profileId = args.getString(0);
        TDProfile.ProfileType type = this.intToProfileType(args.getInt(1));
        String name = args.getString(2);
        TCAgent.onLogin(profileId, type, name);
    }
    
    @SuppressWarnings("unused")
    private void onEvent(final JSONArray args) throws JSONException {
        String eventId = args.getString(0);
        TCAgent.onEvent(MainActivity.context, eventId);
    }
    
    @SuppressWarnings("unused")
    private void onEventWithLabel(final JSONArray args) throws JSONException {
        String eventId = args.getString(0);
        String eventLabel = args.getString(1);
        TCAgent.onEvent(MainActivity.context, eventId, eventLabel);
    }
    
    @SuppressWarnings("unused")
    private void onEventWithParameters(final JSONArray args) throws JSONException {
        String eventId = args.getString(0);
        String eventLabel = args.getString(1);
        String eventDataJson = args.getString(2);
        Map<String, Object> eventData = this.toMap(eventDataJson);
        TCAgent.onEvent(MainActivity.context, eventId, eventLabel, eventData);
    }
    
    @SuppressWarnings("unused")
    private void onEventWithValue(final JSONArray args) throws JSONException {
        String eventId = args.getString(0);
        String eventLabel = args.getString(1);
        String eventDataJson = args.getString(2);
        Map<String, Object> eventData = this.toMap(eventDataJson);
        double eventValue = args.getDouble(3);
        TCAgent.onEvent(MainActivity.context, eventId, eventLabel, eventData, eventValue);
    }
    
    @SuppressWarnings("unused")
    private void onPlaceOrder(final JSONArray args) throws JSONException {
        String profileId = args.getString(0);
        JSONObject orderJson = args.getJSONObject(1);
        Order order = this.orderFromJSONObject(orderJson);
        TCAgent.onPlaceOrder(profileId, order);
    }
    
    @SuppressWarnings("unused")
    private void onOrderPaySucc(final JSONArray args) throws JSONException {
        String profileId = args.getString(0);
        String payType = args.getString(1);
        JSONObject orderJson = args.getJSONObject(2);
        Order order = this.orderFromJSONObject(orderJson);
        TCAgent.onOrderPaySucc(profileId, payType, order);
    }
    
    @SuppressWarnings("unused")
    private void onViewItem(final JSONArray args) throws JSONException {
        String itemId = args.getString(0);
        String category = args.getString(1);
        String name = args.getString(2);
        int unitPrice = args.getInt(3);
        TCAgent.onViewItem(itemId, category, name, unitPrice);
    }
    
    @SuppressWarnings("unused")
    private void onAddItemToShoppingCart(final JSONArray args) throws JSONException {
        String itemId = args.getString(0);
        String category = args.getString(1);
        String name = args.getString(2);
        int unitPrice = args.getInt(3);
        int amount = args.getInt(4);
        TCAgent.onAddItemToShoppingCart(itemId, category, name, unitPrice, amount);
    }
    
    @SuppressWarnings("unused")
    private void onViewShoppingCart(final JSONArray args) throws JSONException {
        JSONObject shoppingCartJson = args.getJSONObject(0);
        ShoppingCart shoppingCart = this.shoppingCartFromJSONObject(shoppingCartJson);
        TCAgent.onViewShoppingCart(shoppingCart);
    }
    
    @SuppressWarnings("unused")
    private void onPage(final JSONArray args) throws JSONException {
        String pageName = args.getString(0);
        if (currPageName != null) {
            TCAgent.onPageEnd(activity, currPageName);
        }
        currPageName = pageName;
        TCAgent.onPageStart(activity, currPageName);
    }

    @SuppressWarnings("unused")
    private void onPageBegin(final JSONArray args) throws JSONException {
        String pageName = args.getString(0);
        currPageName = pageName;
        TCAgent.onPageStart(talkingDataHTML.activity, currPageName);
    }
    
    @SuppressWarnings("unused")
    private void onPageEnd(final JSONArray args) throws JSONException {
        String pageName = args.getString(0);
        TCAgent.onPageEnd(talkingDataHTML.activity, pageName);
        currPageName = null;
    }
    
    @SuppressWarnings("unused")
    private void setLocation(final JSONArray args) {
        
    }
    
    private TDProfile.ProfileType intToProfileType(final int type) {
        switch (type) {
            case 0:
                return TDProfile.ProfileType.ANONYMOUS;
            case 1:
                return TDProfile.ProfileType.REGISTERED;
            case 2:
                return TDProfile.ProfileType.SINA_WEIBO;
            case 3:
                return TDProfile.ProfileType.QQ;
            case 4:
                return TDProfile.ProfileType.QQ_WEIBO;
            case 5:
                return TDProfile.ProfileType.ND91;
            case 6:
                return TDProfile.ProfileType.WEIXIN;
            case 11:
                return TDProfile.ProfileType.TYPE1;
            case 12:
                return TDProfile.ProfileType.TYPE2;
            case 13:
                return TDProfile.ProfileType.TYPE3;
            case 14:
                return TDProfile.ProfileType.TYPE4;
            case 15:
                return TDProfile.ProfileType.TYPE5;
            case 16:
                return TDProfile.ProfileType.TYPE6;
            case 17:
                return TDProfile.ProfileType.TYPE7;
            case 18:
                return TDProfile.ProfileType.TYPE8;
            case 19:
                return TDProfile.ProfileType.TYPE9;
            case 20:
                return TDProfile.ProfileType.TYPE10;
            default:
                return TDProfile.ProfileType.ANONYMOUS;
        }
    }
    
    private Map<String, Object> toMap(String jsonStr) {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            JSONObject jsonObj = new JSONObject(jsonStr);
            Iterator<String> keys = jsonObj.keys();
            String key = null;
            Object value = null;
            while (keys.hasNext()) {
                key = keys.next();
                value = jsonObj.get(key);
                result.put(key, value);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    private Order orderFromJSONObject(JSONObject orderJson) {
        try {
            Order order = Order.createOrder(orderJson.getString("orderId"), orderJson.getInt("total"), orderJson.getString("currencyType"));
            JSONArray items = orderJson.getJSONArray("items");
            for (int i=0; i<items.length(); i++) {
                JSONObject item = items.getJSONObject(i);
                order.addItem(item.getString("itemId"), item.getString("category"), item.getString("name"), item.getInt("unitPrice"), item.getInt("amount"));
            }
            return order;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private ShoppingCart shoppingCartFromJSONObject(JSONObject shoppingCartJson) {
        try {
            ShoppingCart shoppingCart = ShoppingCart.createShoppingCart();
            JSONArray items = shoppingCartJson.getJSONArray("items");
            for (int i=0; i<items.length(); i++) {
                JSONObject item = items.getJSONObject(i);
                shoppingCart.addItem(item.getString("itemId"), item.getString("category"), item.getString("name"), item.getInt("unitPrice"), item.getInt("amount"));
            }
            return shoppingCart;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
}
