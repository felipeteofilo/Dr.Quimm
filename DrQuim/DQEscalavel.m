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
        [self setPosition:CGPointMake(pInicial.x, pInicial.y + 150)];
        [self setAnchorPoint:CGPointMake(0, 0)];
        
        [self setSize:CGSizeMake(largura , pFinal.y - pInicial.y - 145)];
        
        
        //seta o corpo fisico dele de acordo com o anchorpoint da escada
        [self setPhysicsBody:[SKPhysicsBody bodyWithPolygonFromPath:[self pathForRectangleOfSize:self.size withAnchorPoint:self.anchorPoint]]];
        
        self.physicsBody.usesPreciseCollisionDetection = YES;
        //faz ela nao ser afetada pela gravidade
        self.physicsBody.affectedByGravity = NO;
        
        //seta o nome da escada
        [self setName:nomeEscalavel];
    }
    return self;
}

//metodo para centralizar o physics body na textura dele
- (CGPathRef)pathForRectangleOfSize:(CGSize)size withAnchorPoint:(CGPoint)anchor {
    CGPathRef path = CGPathCreateWithRect( CGRectMake(-size.width * anchor.x, -size.height * anchor.y,
                                                      size.width,   size.height), nil);
    return path;
}





@end
