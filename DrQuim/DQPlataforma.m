//
//  DQPlataforma.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 04/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQPlataforma.h"

@implementation DQPlataforma

-(id)init{
    if ([super init]) {
        
        [self setName:@"Plataforma"];
        [self.physicsBody setContactTestBitMask:0x0];
        [self.physicsBody setCollisionBitMask:0x0];
        
    }
    return self;
}
@end
