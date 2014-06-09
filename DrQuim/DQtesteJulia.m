//
//  DQtesteJulia.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQtesteJulia.h"

@implementation DQtesteJulia

-(id)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        [self setBackgroundColor:[UIColor redColor]];
        
        DQFala *fala = [[DQFala alloc]initFala:@"Teste" :CGPointMake(300, 300) :balaoFala];

        [self addChild:fala];
        
    }
    return self;
}

@end
