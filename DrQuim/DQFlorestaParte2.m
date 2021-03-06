//
//  DQFlorestaParte2.m
//  DrQuim
//
//  Created by Julia Yamamoto on 30/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte2.h"

@implementation DQFlorestaParte2

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self configuracoesFase:3];

        [self iniciarFase];
    }
    return self;
}

-(void)iniciarFase
{
    [super iniciarFase];
}

-(void)update: (NSTimeInterval)currentTime
{
    [super update:currentTime];
    [self.hudFase atualizarHud];
}

@end
