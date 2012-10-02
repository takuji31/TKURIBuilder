//
//  TKURIBuilder.m
//  TKURIBuilder
//
//  Created by Nishibayashi Takuji on 12/10/02.
//  Copyright (c) 2012年 Nishibayashi Takuji. All rights reserved.
//

#import "TKURIBuilder.h"

@implementation TKURIBuilder
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
    return @"TODO";
}

-(NSURL *)buildURL {
    return [NSURL URLWithString:[self buildString]];
}

@end
