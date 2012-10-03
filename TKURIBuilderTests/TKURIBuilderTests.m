//
//  TKURIBuilderTests.m
//  TKURIBuilderTests
//
//  Created by Nishibayashi Takuji on 12/10/02.
//  Copyright (c) 2012年 Nishibayashi Takuji. All rights reserved.
//

#import "TKURIBuilderTests.h"
#import "TKURIBuilder.h"

@implementation TKURIBuilderTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testUriString
{
    TKURIBuilder *builder = [[TKURIBuilder alloc]init];
    builder.scheme = @"http";
    builder.host = @"example.com";
    builder.path = @"";
    STAssertEqualObjects(@"http://example.com" ,[builder buildString], @"basic build");

    builder = [[TKURIBuilder alloc]init];
    builder.scheme = @"http";
    builder.host = @"example.com";
    STAssertEqualObjects(@"http://example.com", [builder buildString], @"basic build without path");
    
    builder = [[TKURIBuilder alloc]init];
    builder.scheme = @"http";
    builder.host = @"example.com";
    builder.path = @"/some/path";
    STAssertEqualObjects(@"http://example.com/some/path", [builder buildString], @"basic build with path");
    
    
    builder = [[TKURIBuilder alloc]init];
    builder.scheme = @"http";
    builder.host = @"example.com";
    builder.path = @"/some/path";
    [builder appendQueryString:@"hoge" value:@"fuga"];
    STAssertEqualObjects(@"http://example.com/some/path?hoge=fuga", [builder buildString], @"build with single query");
    
    builder = [[TKURIBuilder alloc]init];
    builder.scheme = @"http";
    builder.host = @"example.com";
    builder.path = @"/some/path";
    [builder appendQueryString:@"hoge" value:@"fuga"];
    [builder appendQueryString:@"foo" value:@"bar"];
    STAssertEqualObjects(@"http://example.com/some/path?hoge=fuga&foo=bar", [builder buildString], @"build with multi query");
    
    builder = [[TKURIBuilder alloc]init];
    builder.scheme = @"http";
    builder.host = @"example.com";
    builder.path = @"/some/path";
    [builder appendQueryString:@"key1" value:@"日本語"];
    [builder appendQueryString:@"key2" value:@"です"];
    STAssertEqualObjects(@"http://example.com/some/path?key1=%E6%97%A5%E6%9C%AC%E8%AA%9E&key2=%E3%81%A7%E3%81%99", [builder buildString], @"build with multi query");
    
}

@end
