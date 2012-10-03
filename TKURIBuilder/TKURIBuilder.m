//
//  TKURIBuilder.m
//  TKURIBuilder
//
//  Created by Nishibayashi Takuji on 12/10/02.
//  Copyright (c) 2012年 Nishibayashi Takuji. All rights reserved.
//

#import "TKURIBuilder.h"

@implementation TKURIBuilder

+(NSString *)encode:(NSString *)str {
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                        NULL,
                                                        (CFStringRef)str,
                                                        NULL,
                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                        kCFStringEncodingUTF8 );
}

+(NSString *)decode:(NSString *)str {
    return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                         NULL,
                                                                         (CFStringRef) str,
                                                                         CFSTR(""),
                                                                         kCFStringEncodingUTF8);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.query = [@{} mutableCopy];
    }
    return self;
}

- (id)initWithUriString:(NSString *)uriString
{
    self = [self init];
    if (self) {
#warning TODO parse uri string
    }
    return self;
}

-(id)initWithUriString:(NSString *)uriString andParams:(NSDictionary *)params
{
    self = [self init];
    if (self) {
        self.query = [params mutableCopy];
#warning TODO parse uri string
    }
    return self;
}

-(id)initWithURL:(NSURL *)url {
    self = [self initWithUriString:[url absoluteString]];
    return self;
}

-(NSString *)buildString {
    NSMutableString *uri = [@"" mutableCopy];
    [uri appendFormat:@"%@://%@", _scheme, _host];
    NSMutableString *path = [_path mutableCopy];
    if (!path) {
        path = [@"" mutableCopy];
    }
    NSRange slashRange = [path rangeOfString:@"^/" options:NSRegularExpressionSearch];
    if (path.length != 0 && slashRange.location == NSNotFound) {
        [path insertString:@"/" atIndex:0];
    }
    [uri appendString:path];
    NSMutableString *queryString = [@"" mutableCopy];
    for (NSString *name in [_query keyEnumerator]) {
        NSString *param = [_query objectForKey:name];
        [queryString appendFormat:@"&%@=%@", [TKURIBuilder encode:name], [TKURIBuilder encode:param]];
    }
    if (queryString.length != 0) {
        [queryString replaceCharactersInRange:NSMakeRange(0, 1) withString:@"?"];
    }
    [uri appendString:queryString];
    if (_fragment.length != 0) {
        [uri appendFormat:@"#%@", _fragment];
    }
    
    return uri;
}

-(NSURL *)buildURL {
    return [NSURL URLWithString:[self buildString]];
}

@end
