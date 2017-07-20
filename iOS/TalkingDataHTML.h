//
//  TalkingDataHTML.h
//  TalkingData-HTML
//
//  Created by liweiqiang on 14-1-9.
//  Copyright (c) 2014年 tendcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface TalkingDataHTML : NSObject

/**
 *	@method	execute:webView:
 *
 *	@param 	url         NSURL*
 *  @param 	webView     id(UIWebView* or WKWebView*)
 */
+ (BOOL)execute:(NSURL *)url webView:(id)webView;

@end
