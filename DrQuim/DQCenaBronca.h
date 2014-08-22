//
//  DQCenaBronca.h
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 21/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQJogador.h"
#import "DQNpc.h"
#import "DQConfiguracaoFase.h"
#import "DQControleCorpoFisico.h"
#import "DQFalasNoJogoControle.h"
#import "DQVila.h"

@interface DQCenaBronca : SKScene<SKPhysicsContactDelegate>

@property DQNpc *maeDeTodos;
@property DQNpc *cacador;
@property DQJogador *jogador;

@property DQFalasNoJogoControle *controleDeFalas;
@property CGPoint pontoDeToqueAndar;
@property SKSpriteNode *direcional;

@property BOOL comecouAlerta;
@property SKScene *cenaAnterior;

-(id)initCena:(CGSize)size cena:(SKScene*)cenaAnterior;
@end
