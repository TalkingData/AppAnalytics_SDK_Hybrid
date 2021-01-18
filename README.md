## TalkingData App Analytics Hybrid SDK
App Analytics Hybrid 平台 SDK 由`封装层`和`Native SDK`两部分构成，目前GitHub上提供了封装层代码，需要从 [TalkingData官网](https://www.talkingdata.com/spa/sdk/#/config) 下载最新版的 Android 和 iOS 平台 Native SDK，组合使用。

### 集成说明
1. 下载本项目（封装层）到本地；  
2. 访问 [TalkingData官网](https://www.talkingdata.com/spa/sdk/#/config) 下载最新版的 Android 和 iOS 平台 App Analytics SDK（ Native SDK）
	- 方法1：选择 Hybrid 平台进行功能定制；
	- 方法2：分别选择 Android 和 iOS 平台进行功能定制，请确保两个平台功能项一致；  
3. 将下载的最新版 `Native SDK` 复制到`封装层`中，构成完整的 Hybrid SDK。  
	- Android 平台  
	将最新的 .jar 文件复制到 `Android` 目录下
	- iOS 平台  
	将最新的 .h和.a 文件复制到 `iOS` 目录下
4. 按 `Native SDK` 功能选项对`封装层`代码进行必要的删减，详见“注意事项”第2条；
5. 将 Hybrid SDK 集成您需要统计的工程中，并按 [集成文档](http://doc.talkingdata.com/posts/143) 进行必要配置和功能调用。

### 注意事项
1. 分别选择 Android 和 iOS 平台进行功能定制时，请确保两个平台功能项一致。
2. 如果申请 Native SDK 时只选择了部分功能，则需要在本项目中删除未选择功能对应的封装层代码。  
	a) 未选择`自定义事件`功能则删除以下3部分  
	删除 `TalkingData.js` 文件中如下代码：
	
	```
		onEvent:function(eventId) {
			if (isWebviewFlag) {
				exec("onEvent", [eventId]);
			}
		},
		onEventWithLabel:function(eventId, eventLabel) {
			if (isWebviewFlag) {
				exec("onEventWithLabel", [eventId, eventLabel]);
			}
		},
		onEventWithParameters:function(eventId, eventLabel, eventData) {
			if (isWebviewFlag) {
				exec("onEventWithParameters", [eventId, eventLabel, eventData]);
			}
		},
		onEventWithValue:function(eventId, eventLabel, eventData, eventValue) {
			if (isWebviewFlag) {
				exec("onEventWithParameters", [eventId, eventLabel, eventData, eventValue]);
			}
		},
	```
	删除 `Android/TalkingDataHTML.java` 文件中如下代码：
	
	```
		@SuppressWarnings("unused")
		private void onEvent(final JSONArray args) throws JSONException {
			...
		}
		
		@SuppressWarnings("unused")
		private void onEventWithLabel(final JSONArray args) throws JSONException {
			...
		}
		
		@SuppressWarnings("unused")
		private void onEventWithParameters(final JSONArray args) throws JSONException {
			...
		}
		
		@SuppressWarnings("unused")
		private void onEventWithValue(final JSONArray args) throws JSONException {
			...
		}
	```
	```
		private Map<String, Object> toMap(String jsonStr)
		{
			...
		}
	```
	删除 `iOS/TalkingDataHTML.m` 文件中如下代码：
	
	```
	- (void)onEvent:(NSArray *)arguments {
		...
	}
	
	- (void)onEventWithLabel:(NSArray *)arguments {
		...
	}
	
	- (void)onEventWithParameters:(NSArray *)arguments {
		...
	}
	
	- (void)onEventWithValue:(NSArray *)arguments {
		...
	}
	```
	b) 未选择`标准化事件分析`功能则删除以下3部分  
	删除 `TalkingData.js` 文件中如下代码：
	
	```
	var TalkingDataOrder = {
		...
	};
	
	var TalkingDataShoppingCart = {
		...
	};
	```
	```
		onPlaceOrder:function(profileId, order) {
			if (isWebviewFlag) {
				exec("onPlaceOrder", [profileId, order]);
			};
		},
		onOrderPaySucc:function(profileId, payType, order) {
			if (isWebviewFlag) {
				exec("onOrderPaySucc", [profileId, payType, order]);
			};
		},
		onViewItem:function(itemId, category, name, unitPrice) {
			if (isWebviewFlag) {
				exec("onViewItem", [itemId, category, name, unitPrice]);
			};
		},
		onAddItemToShoppingCart:function(itemId, category, name, unitPrice, amount) {
			if (isWebviewFlag) {
				exec("onAddItemToShoppingCart", [itemId, category, name, unitPrice, amount]);
			};
		},
		onViewShoppingCart:function(shoppingCart) {
			if (isWebviewFlag) {
				exec("onViewShoppingCart", [shoppingCart]);
			};
		},
	```
	删除 `Android/TalkingDataHTML.java` 文件中如下代码：
	
	```
	import com.tendcloud.tenddata.Order;
	import com.tendcloud.tenddata.ShoppingCart;
	```
	```
		@SuppressWarnings("unused")
		private void onPlaceOrder(final JSONArray args) throws JSONException {
			...
		}
		
		@SuppressWarnings("unused")
		private void onOrderPaySucc(final JSONArray args) throws JSONException {
			...
		}
		
		@SuppressWarnings("unused")
		private void onViewItem(final JSONArray args) throws JSONException {
			...
		}
		
		@SuppressWarnings("unused")
		private void onAddItemToShoppingCart(final JSONArray args) throws JSONException {
			...
		}
		
		@SuppressWarnings("unused")
		private void onViewShoppingCart(final JSONArray args) throws JSONException {
			...
		}
	```
	```
		private Order orderFromJSONObject(JSONObject orderJson) {
			...
		}
		
		private ShoppingCart shoppingCartFromJSONObject(JSONObject shoppingCartJson) {
			...
		}
	```
	删除 `iOS/TalkingDataHTML.m` 文件中如下代码：
	
	```
	- (void)onPlaceOrder:(NSArray *)arguments {
		...
	}
	
	- (void)onOrderPaySucc:(NSArray *)arguments {
		...
	}
	
	- (void)onViewItem:(NSArray *)arguments {
		...
	}
	
	- (void)onAddItemToShoppingCart:(NSArray *)arguments {
		...
	}
	
	- (void)onViewShoppingCart:(NSArray *)arguments {
		...
	}
	```
	```
	- (TalkingDataOrder *)orderFormDictionary:(NSDictionary *)orderDic {
		...
	}
	
	- (TalkingDataShoppingCart *)shoppingCartFromDictionary:(NSDictionary *)shoppingCartDic {
		...
	}
	```
	c) 未选择`页面统计`功能则删除以下3部分  
	删除 `TalkingData.js` 文件中如下代码：
	
	```
		onPage:function(pageName) {
			if (isWebviewFlag) {
				exec("onPage", [pageName]);
			};
		},
		onPageBegin:function(pageName) {
			if (isWebviewFlag) {
				exec("onPageBegin", [pageName]);
			}
		},
		onPageEnd:function(pageName) {
			if (isWebviewFlag) {
				exec("onPageEnd", [pageName]);
			}
		},
	```
	删除 `Android/TalkingDataHTML.java` 文件中如下代码：
	
	```
		String currPageName = null;
	```
	```
		@SuppressWarnings("unused")
		private void onPage(final JSONArray args) throws JSONException {
			...
		}
		
		@SuppressWarnings("unused")
		private void onPageBegin(final JSONArray args) throws JSONException {
			...
		}
		
		@SuppressWarnings("unused")
		private void onPageEnd(final JSONArray args) throws JSONException {
			...
		}
	```
	删除 `iOS/TalkingDataHTML.m` 文件中如下代码：
	
	```
	@property (nonatomic, strong) NSString *currPageName;
	```
	```
	- (void)onPage:(NSArray *)arguments {
		...
	}
	
	- (void)onPageBegin:(NSArray *)arguments {
		...
	}
	
	- (void)onPageEnd:(NSArray *)arguments {
		...
	}
	```
