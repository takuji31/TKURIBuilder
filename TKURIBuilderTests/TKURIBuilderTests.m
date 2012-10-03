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
    builder.query = [@{@"hoge" : @"fuga"} mutableCopy];
    STAssertEqualObjects(@"http://example.com/some/path?hoge=fuga", [builder buildString], @"build with single query");
    
    builder = [[TKURIBuilder alloc]init];
    builder.scheme = @"http";
    builder.host = @"example.com";
    builder.path = @"/some/path";
    builder.query = [@{@"hoge" : @"fuga", @"foo": @"bar"} mutableCopy];
    STAssertEqualObjects(@"http://example.com/some/path?foo=bar&hoge=fuga", [builder buildString], @"build with multi query");
    
}

@end
