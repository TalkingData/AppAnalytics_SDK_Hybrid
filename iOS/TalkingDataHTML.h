//
//  TalkingDataHTML.h
//  TalkingData-HTML
//
//  Created by liweiqiang on 14-1-9.
//  Copyright (c) 2014年 tendcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WKWebView;

@interface TalkingDataHTML : NSObject

/**
 *	@method	execute:webView:
 *
 *	@param 	url         NSURL*
 *  @param 	webView     WKWebView*
 */
+ (BOOL)execute:(NSURL *)url webView:(WKWebView *)webView;

@end
