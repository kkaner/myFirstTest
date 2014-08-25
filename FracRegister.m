//
//  FracRegister.m
//  Fraction
//
//  Created by KimHeejae on 2014. 8. 6..
//  Copyright (c) 2014년 KimHeejae. All rights reserved.
//

#import "FracRegister.h"

@implementation FracRegister

-(id)init{
    if((self = [super init]) != nil)
        current = prev = nil;
    return self;
}
-(void)dealloc{
    [current release];
    [prev release];
    [super dealloc];
}
-(Fraction *)currentValue{
    return current;
}
-(void)setCurrentvalue:(Fraction *)val{
    [val retain];
    [current release];
    current = val;
    
    [prev release];
    prev = nil;
}
-(BOOL)undoCalc{
    if(prev == nil){
        return NO;
    }
    [current release];
    current = prev;
    prev = nil;
    
    return YES;
}
-(void)calculate:(char)op with:(Fraction *)arg{
    Fraction *result = nil;
    
    if(current != nil && arg != nil){
        switch(op){
        case '+':
            result = [current add: arg];
            break;
        case '-':
            result = [current sub: arg];
            break;
        case '*':
            result = [current mul: arg];
            break;
        case '/':
            result = [current div: arg];
            break;
        default:
            break;
        }
    }
    
    if(result != nil){
        [result retain];
        [prev release];
        prev = current;
        current = result;
    }
    else{
        printf("Illegal Operation\n");
    }
}

@end
