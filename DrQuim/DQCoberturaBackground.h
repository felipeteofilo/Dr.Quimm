//
//  DQCoberturaBackground.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 15/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQConfiguracaoFase.h"

static NSString* NomeNodeCobertura=@"CoberturaBackground";
static NSString* NomePosFinal=@"PosFinal";

@interface DQCoberturaBackground : SKSpriteNode

@property CGPoint posFinal;

-(id)initCoberturaParte:(int)_parte daFase:(int)_fase;
-(void)manipulaCobertura:(CGPoint)posJogador;
@end
