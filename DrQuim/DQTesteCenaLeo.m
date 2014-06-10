//
//  DQTesteCenaLeo.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTesteCenaLeo.h"

@implementation DQTesteCenaLeo

-(id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        self.falaTeste = [[DQFala alloc]initComSujeito:@"Sujeito" Texto:@"Esta é uma fala teste. \rVou ficar feliz se funcionar!"];
        
        [self.falaTeste desenhaNaTela];
        
        [self addChild:self.falaTeste];
    }
    return self;
}

@end
