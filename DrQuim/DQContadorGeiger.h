//
//  DQContadorGeiger.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQUtils.h"

@interface DQContadorGeiger : SKSpriteNode
{
    NSMutableArray *framesAnimacao;
}

@property int nivelPerigo;
@property float velocidadeAnimacao;

-(id)initContadorNivelRadicao:(int)nivelRadiacao;

-(void)aumentarNivelPerigo;
-(void)diminuirNivelPerigo;

-(void)setarNivelPerigo:(int)valor;
@end
