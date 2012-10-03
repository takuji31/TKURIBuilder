//
//  TKURIBuilder.h
//  TKURIBuilder
//
//  Created by Nishibayashi Takuji on 12/10/02.
//  Copyright (c) 2012年 Nishibayashi Takuji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKURIBuilder : NSObject
@property NSString *scheme;
@property NSString *host;
@property NSString *path;
@property NSMutableArray *query;
@property NSString *fragment;

-(id) init;
/*
TODO
-(id) initWithUriString:(NSString *)uriString;
-(id) initWithURL:(NSURL *)url;
-(id) initWithUriString:(NSString *)uriString andParams:(NSDictionary *)params;
*/

+(NSString *)encode:(NSString *)str;
+(NSString *)decode:(NSString *)str;
+(TKURIBuilder *)httpURIBuilder;
+(TKURIBuilder *)httpsURIBuilder;

-(NSString *) buildString;
-(NSURL *) buildURL;
-(void) appendQueryString:(NSString *)key value:(NSString *)value;
-(void) appendQueries:(NSString *)key value:(NSArray *)values;
-(void) replaceQueryString:(NSString *)key value:(NSString *)value;
-(void) replaceQueries:(NSString *)key values:(NSArray *)values;
@end
