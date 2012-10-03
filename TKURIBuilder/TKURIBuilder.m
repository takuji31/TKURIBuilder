//
//  TKURIBuilder.m
//  TKURIBuilder
//
//  Created by Nishibayashi Takuji on 12/10/02.
//  Copyright (c) 2012年 Nishibayashi Takuji. All rights reserved.
//

#import "TKURIBuilder.h"

@implementation TKURIBuilder

+(TKURIBuilder *)httpURIBuilder {
    TKURIBuilder *builder = [[self alloc]init];
    builder.scheme = @"http";
    return builder;
}

+(TKURIBuilder *)httpsURIBuilder {
    TKURIBuilder *builder = [[self alloc]init];
    builder.scheme = @"https";
    return builder;
}

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
        self.query = [@[] mutableCopy];
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
#warning TODO parse query dictionary
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
    for (NSDictionary *param in _query) {
        NSString *name = param[@"name"];
        NSArray *values = param[@"values"];
        for (NSString *value in values) {
            [queryString appendFormat:@"&%@=%@", [TKURIBuilder encode:name], [TKURIBuilder encode:value]];
        }
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

-(void)appendQueryString:(NSString *)key value:(NSString *)value {
    [self appendQueries:key value:@[value]];
}

-(void)appendQueries:(NSString *)key value:(NSArray *)values {
    NSArray *names = [_query valueForKeyPath:@"name"];
    NSInteger index = [names indexOfObject:key];
    if (index != NSNotFound) {
        NSMutableArray *values = [_query objectAtIndex:index][@"values"];
        [values addObjectsFromArray:values];
    } else {
        [self replaceQueries:key values:values];
    }
}

-(void)replaceQueryString:(NSString *)key value:(NSString *)value {
    [self replaceQueries:key values: @[value]];
}

-(void)replaceQueries:(NSString *)key values:(NSArray *)values {
    NSArray *names = [_query valueForKeyPath:@"name"];
    NSInteger index = [names indexOfObject:key];
    NSDictionary *pair = @{@"name" : key, @"values": [values mutableCopy]};
    if (index != NSNotFound) {
        [_query replaceObjectAtIndex:index withObject:pair];
    } else {
        [_query addObject:pair];
    }
}
@end
