//
//  TalkingDataHTML.m
//  TalkingData-HTML
//
//  Created by liweiqiang on 14-1-9.
//  Copyright (c) 2014年 tendcloud. All rights reserved.
//

#import "TalkingDataHTML.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "TalkingData.h"


@interface TalkingDataHTML ()

@property (nonatomic, strong) NSString *currPageName;

@end


@implementation TalkingDataHTML

+ (BOOL)execute:(NSURL *)url webView:(id)webView {
    NSString *parameters = [url.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([parameters hasPrefix:@"talkingdata"]) {
        static TalkingDataHTML *talkingDataHTML = nil;
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            talkingDataHTML = [[TalkingDataHTML alloc] init];
        });
        NSString *str = [parameters substringFromIndex:12];
        NSDictionary *dic = [talkingDataHTML jsonToDictionary:str];
        NSString *functionName = [dic objectForKey:@"functionName"];
        NSArray *args = [dic objectForKey:@"arguments"];
        if ([functionName isEqualToString:@"getDeviceId"]) {
            [talkingDataHTML getDeviceId:args webView:webView];
        } else {
            SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:", functionName]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if ([talkingDataHTML respondsToSelector:selector]) {
                [talkingDataHTML performSelector:selector withObject:args];
            }
#pragma clang diagnostic pop
        }
        return YES;
    }
    
    return NO;
}

- (void)getDeviceId:(NSArray *)arguments webView:(id)webView {
    NSString *arg0 = [arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]] || arg0.length == 0) {
        return;
    }
    NSString *deviceId = [TalkingData getDeviceID];
    NSString *callBack = [NSString stringWithFormat:@"%@('%@')", arg0, deviceId];
    if ([webView isKindOfClass:[UIWebView class]]) {
        [webView stringByEvaluatingJavaScriptFromString:callBack];
    } else if ([webView isKindOfClass:[WKWebView class]]) {
        [webView evaluateJavaScript:callBack completionHandler:nil];
    }
}

- (void)setLocation:(NSArray *)arguments {
    NSString *arg0 = [arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *arg1 = [arguments objectAtIndex:1];
    if (arg1 == nil || [arg1 isKindOfClass:[NSNull class]]) {
        return;
    }
    double latitude = [arg0 doubleValue];
    double longitude = [arg1 doubleValue];
    [TalkingData setLatitude:latitude longitude:longitude];
}

- (void)setAntiCheatingEnabled:(NSArray *)arguments {
    NSString *arg0 = [arguments objectAtIndex:0];
    if (arg0 == nil || [arg0 isKindOfClass:[NSNull class]]) {
        return;
    }
    BOOL enabled = [arg0 boolValue];
    [TalkingData setAntiCheatingEnabled:enabled];
}

- (void)onRegister:(NSArray *)arguments {
    NSString *accountId = [arguments objectAtIndex:0];
    if (![accountId isKindOfClass:[NSString class]]) {
        accountId = nil;
    }
    NSUInteger type = [[arguments objectAtIndex:1] unsignedIntegerValue];
    NSString *name = [arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    [TalkingData onRegister:accountId type:type name:name];
}

- (void)onLogin:(NSArray *)arguments {
    NSString *accountId = [arguments objectAtIndex:0];
    if (![accountId isKindOfClass:[NSString class]]) {
        accountId = nil;
    }
    NSUInteger type = [[arguments objectAtIndex:1] unsignedIntegerValue];
    NSString *name = [arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    [TalkingData onLogin:accountId type:type name:name];
}

- (void)onEvent:(NSArray *)arguments {
    NSString *eventId = [arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    [TalkingData trackEvent:eventId];
}

- (void)onEventWithLabel:(NSArray *)arguments {
    NSString *eventId = [arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *eventLabel = [arguments objectAtIndex:1];
    if ([eventLabel isKindOfClass:[NSNull class]]) {
        eventLabel = nil;
    }
    [TalkingData trackEvent:eventId label:eventLabel];
}

- (void)onEventWithParameters:(NSArray *)arguments {
    NSString *eventId = [arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *eventLabel = [arguments objectAtIndex:1];
    if (eventLabel == nil || [eventLabel isKindOfClass:[NSNull class]]) {
        eventLabel = nil;
    }
    NSDictionary *parameters = [arguments objectAtIndex:2];
    if (parameters == nil && [parameters isKindOfClass:[NSNull class]]) {
        parameters = nil;
    }
    [TalkingData trackEvent:eventId label:eventLabel parameters:parameters];
}

- (void)onPlaceOrder:(NSArray *)arguments {
    NSString *accountId = [arguments objectAtIndex:0];
    if (![accountId isKindOfClass:[NSString class]]) {
        accountId = nil;
    }
    NSDictionary *orderDic = [arguments objectAtIndex:1];
    if (![orderDic isKindOfClass:[NSDictionary class]]) {
        orderDic = nil;
    }
    TalkingDataOrder *order = [self orderFormDictionary:orderDic];
    [TalkingData onPlaceOrder:accountId order:order];
}

- (void)onOrderPaySucc:(NSArray *)arguments {
    NSString *accountId = [arguments objectAtIndex:0];
    if (![accountId isKindOfClass:[NSString class]]) {
        accountId = nil;
    }
    NSString *payType = [arguments objectAtIndex:1];
    if (![payType isKindOfClass:[NSString class]]) {
        payType = nil;
    }
    NSDictionary *orderDic = [arguments objectAtIndex:2];
    if (![orderDic isKindOfClass:[NSDictionary class]]) {
        orderDic = nil;
    }
    TalkingDataOrder *order = [self orderFormDictionary:orderDic];
    [TalkingData onOrderPaySucc:accountId payType:payType order:order];
}

- (void)onViewItem:(NSArray *)arguments {
    NSString *itemId = [arguments objectAtIndex:0];
    if (![itemId isKindOfClass:[NSString class]]) {
        itemId = nil;
    }
    NSString *category = [arguments objectAtIndex:1];
    if (![category isKindOfClass:[NSString class]]) {
        category = nil;
    }
    NSString *name = [arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    int unitPrice = [[arguments objectAtIndex:3] intValue];
    [TalkingData onViewItem:itemId category:category name:name unitPrice:unitPrice];
}

- (void)onAddItemToShoppingCart:(NSArray *)arguments {
    NSString *itemId = [arguments objectAtIndex:0];
    if (![itemId isKindOfClass:[NSString class]]) {
        itemId = nil;
    }
    NSString *category = [arguments objectAtIndex:1];
    if (![category isKindOfClass:[NSString class]]) {
        category = nil;
    }
    NSString *name = [arguments objectAtIndex:2];
    if (![name isKindOfClass:[NSString class]]) {
        name = nil;
    }
    int unitPrice = [[arguments objectAtIndex:3] intValue];
    int amount = [[arguments objectAtIndex:4] intValue];
    [TalkingData onAddItemToShoppingCart:itemId category:category name:name unitPrice:unitPrice amount:amount];
}

- (void)onViewShoppingCart:(NSArray *)arguments {
    NSDictionary *shoppingCartDic = [arguments objectAtIndex:0];
    if (![shoppingCartDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    TalkingDataShoppingCart *shoppingCart = [self shoppingCartFromDictionary:shoppingCartDic];
    [TalkingData onViewShoppingCart:shoppingCart];
}

- (void)onPage:(NSArray *)arguments {
    NSString *pageName = [arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if (self.currPageName) {
        [TalkingData trackPageEnd:self.currPageName];
    }
    self.currPageName = pageName;
    [TalkingData trackPageBegin:self.currPageName];
}

- (void)onPageBegin:(NSArray *)arguments {
    NSString *pageName = [arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    self.currPageName = pageName;
    [TalkingData trackPageBegin:pageName];
}

- (void)onPageEnd:(NSArray *)arguments {
    NSString *pageName = [arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    [TalkingData trackPageEnd:pageName];
    self.currPageName = nil;
}

- (NSDictionary *)jsonToDictionary:(NSString *)jsonStr {
    if (jsonStr) {
        NSError *error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (error == nil && [object isKindOfClass:[NSDictionary class]]) {
            return object;
        }
    }
    
    return nil;
}

- (TalkingDataOrder *)orderFormDictionary:(NSDictionary *)orderDic {
    TalkingDataOrder *order = [TalkingDataOrder createOrder:orderDic[@"orderId"] total:[orderDic[@"total"] intValue] currencyType:orderDic[@"currencyType"]];
    NSArray *items = orderDic[@"items"];
    for (NSDictionary *item in items) {
        [order addItem:item[@"itemId"] category:item[@"category"] name:item[@"name"] unitPrice:[item[@"unitPrice"] intValue] amount:[item[@"amount"] intValue]];
    }
    
    return order;
}

- (TalkingDataShoppingCart *)shoppingCartFromDictionary:(NSDictionary *)shoppingCartDic {
    TalkingDataShoppingCart *shoppingCart = [TalkingDataShoppingCart createShoppingCart];
    NSArray *items = shoppingCartDic[@"items"];
    for (NSDictionary *item in items) {
        [shoppingCart addItem:item[@"itemId"] category:item[@"category"] name:item[@"name"] unitPrice:[item[@"unitPrice"] intValue] amount:[item[@"amount"] intValue]];
    }
    
    return shoppingCart;
}

@end
