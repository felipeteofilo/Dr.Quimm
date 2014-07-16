//
//  DQEscalavel.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 13/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQEscalavel.h"

@implementation DQEscalavel

-(id)initEscalavelComPontoInicial:(CGPoint)pInicial ePontoFinal:(CGPoint)pFinal eLargura:(float)largura{
    if (self=[super init]) {
        //o ponto final servirá para determinar até onde o objeto irá
        [self setPosition:pInicial];
        [self setAnchorPoint:CGPointMake(0, 0)];
        
        [self setSize:CGSizeMake(largura, pFinal.y - pInicial.y)];
        
        [self setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:self.size center:CGPointMake(0, 0.0)]];
        
        
        
        self.physicsBody.affectedByGravity = NO;
        
        
        
        //Representaçao visual
        [self setColor:[UIColor purpleColor]];
        
        [self setName:nomeEscalavel];
    }
    return self;
}

@end
