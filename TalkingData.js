var isWebviewFlag;

function setWebViewFlag() {
    isWebviewFlag = true;
};

function loadURL(url) {
    var iFrame;
    iFrame = document.createElement("iframe");
    iFrame.setAttribute("src", url);
    iFrame.setAttribute("style", "display:none;");
    iFrame.setAttribute("height", "0px");
    iFrame.setAttribute("width", "0px");
    iFrame.setAttribute("frameborder", "0");
    document.body.appendChild(iFrame);
    iFrame.parentNode.removeChild(iFrame);
    iFrame = null;
};

function exec(funName, args) {
    var commend = {
        functionName:funName,
        arguments:args
    };
    var jsonStr = JSON.stringify(commend);
    var url = "talkingdata:" + jsonStr;
    loadURL(url);
};

var TalkingDataShoppingCart = {
    createShoppingCart:function() {
        var shoppingCart = {};
        shoppingCart.items = [];

        shoppingCart.addItem = function(itemId, category, name, unitPrice, amount) {
            var item = {
                itemId: itemId,
                category: category,
                name: name,
                unitPrice: unitPrice,
                amount: amount
            };
            shoppingCart.items.push(item);
        }

        return shoppingCart;
    }
};

var TalkingData = {

    ProfileType: {
        ANONYMOUS   : 0,
        REGISTERED  : 1,
        SINA_WEIBO  : 2,
        QQ          : 3,
        QQ_WEIBO    : 4,
        ND91        : 5,
        WEIXIN      : 6,
        TYPE1       : 11,
        TYPE2       : 12,
        TYPE3       : 13,
        TYPE4       : 14,
        TYPE5       : 15,
        TYPE6       : 16,
        TYPE7       : 17,
        TYPE8       : 18,
        TYPE9       : 19,
        TYPE10      : 20
    },

    // 注册事件
    // profileId : 帐户ID
    // type      : 帐户类型
    // name      : 帐户昵称
    onRegister:function(profileId, type, name) {
        if (isWebviewFlag) {
            exec("onRegister", [profileId, type, name]);
        }
    },

    // 登录事件
    // profileId : 帐户ID
    // type      : 帐户类型
    // name      : 帐户昵称
    onLogin:function(profileId, type, name) {
        if (isWebviewFlag) {
            exec("onLogin", [profileId, type, name]);
        }
    },
 
    // 触发自定义事件
    // eventId   : 自定义事件的 eventId
    onEvent:function(eventId) {
        if (isWebviewFlag) {
            exec("onEvent", [eventId]);
        }
    },

    // 触发自定义事件
    // eventId   : 自定义事件的 eventId
    // eventLabel: 自定义事件的事件标签
    onEventWithLabel:function(eventId, eventLabel) {
        if (isWebviewFlag) {
            exec("onEventWithLabel", [eventId, eventLabel]);
        }
    },

    // 触发自定义事件
    // eventId   : 自定义事件的 eventId
    // eventLabel: 自定义事件的事件标签
    // eventData : 自定义事件的数据，Json 对象格式
    onEventWithParameters:function(eventId, eventLabel, eventData) {
        if (isWebviewFlag) {
            exec("onEventWithParameters", [eventId, eventLabel, eventData]);
        }
    },

    // 触发自定义事件
    // eventId   : 自定义事件的 eventId
    // eventLabel: 自定义事件的事件标签
    // eventData : 自定义事件的数据，Json 对象格式
    // eventValue: 自定义事件的事件数值
    onEventWithValue:function(eventId, eventLabel, eventData, eventValue) {
        if (isWebviewFlag) {
            exec("onEventWithValue", [eventId, eventLabel, eventData, eventValue]);
        }
    },

    // 下单
    // orderId      : 订单ID
    // amount       : 金额
    // currencyType : 货币类型
    onPlaceOrder:function(orderId, amount, currencyType) {
        if (isWebviewFlag) {
            exec("onPlaceOrder", [orderId, amount, currencyType]);
        };
    },

    // 支付订单
    // orderId      : 订单ID
    // amount       : 金额
    // currencyType : 货币类型
    // payType      : 支付类型
    onOrderPaySucc:function(orderId, amount, currencyType, payType) {
        if (isWebviewFlag) {
            exec("onOrderPaySucc", [orderId, amount, currencyType, payType]);
        };
    },

    // 取消订单
    // orderId      : 订单ID
    // amount       : 金额
    // currencyType : 货币类型
    onCancelOrder:function(orderId, amount, currencyType) {
        if (isWebviewFlag) {
            exec("onCancelOrder", [orderId, amount, currencyType]);
        };
    },

    // 查看商品
    // itemId    : 商品ID
    // category  : 商品类别
    // name      : 商品名称
    // unitPrice : 商品单价
    onViewItem:function(itemId, category, name, unitPrice) {
        if (isWebviewFlag) {
            exec("onViewItem", [itemId, category, name, unitPrice]);
        };
    },

    // 添加商品到购物车
    // itemId    : 商品ID
    // category  : 商品类别
    // name      : 商品名称
    // unitPrice : 商品单价
    // amount    : 商品数量
    onAddItemToShoppingCart:function(itemId, category, name, unitPrice, amount) {
        if (isWebviewFlag) {
            exec("onAddItemToShoppingCart", [itemId, category, name, unitPrice, amount]);
        };
    },

    // 查看购物车
    // shoppingCart : 购物车详情
    onViewShoppingCart:function(shoppingCart) {
        if (isWebviewFlag) {
            exec("onViewShoppingCart", [shoppingCart]);
        };
    },

    // 触发页面事件，在页面加载完毕的时候调用，记录页面名称和使用时长，一个页面调用这个接口后就不用再调用 onPageBegin 和 onPageEnd 接口了
    // pageName  : 页面自定义名称
    onPage:function(pageName) {
        if (isWebviewFlag) {
            exec("onPage", [pageName]);
        };
    },

    // 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageEnd 配合使用
    // pageName  : 页面自定义名称
    onPageBegin:function(pageName) {
        if (isWebviewFlag) {
            exec("onPageBegin", [pageName]);
        }
    },

    // 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 onPageBegin 配合使用
    // pageName  : 页面自定义名称
    onPageEnd:function(pageName) {
        if (isWebviewFlag) {
            exec("onPageEnd", [pageName]);
        }
    },

    // 设置位置经纬度
    // latitude  : 纬度
    // longitude : 经度
    setLocation:function(latitude, longitude) {
        if (isWebviewFlag) {
            exec("setLocation", [latitude, longitude]);
        }
    },

    // 获取 TalkingData Device Id，并将其作为参数传入 JS 的回调函数
    // callBack  : 处理 deviceId 的回调函数
    getDeviceId:function(callBack) {
        if (isWebviewFlag) {
            exec("getDeviceId", [callBack.name]);
        }
    },
    // 获取 oaid，并将其作为参数传入 JS 的回调函数
    // callBack  : 处理 oaid 的回调函数
    getOAID:function(callBack) {
        if (isWebviewFlag) {
            exec("getOAID", [callBack.name]);
        }
    }
};
