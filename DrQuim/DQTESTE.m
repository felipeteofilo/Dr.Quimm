//
//  DQTESTE.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTESTE.h"

@implementation DQTESTE

-(id)initComDicionario: (NSDictionary *)dicionarioDaFala eSize:(CGSize )size
{
    if (self = [super initWithSize:size]) {
        DQFala *fala = [[DQFala alloc]initComDicionario:dicionarioDaFala eTamanho:size];
        [fala setAnchorPoint:CGPointMake(0, 0)];
        
        
        [self addChild:fala];
    }
    return self;
}

@end
