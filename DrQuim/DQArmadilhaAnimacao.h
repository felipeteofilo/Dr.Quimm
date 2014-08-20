//
//  DQArmadilhaAnimacao.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 18/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQArmadilha.h"
#import "DQAnimal.h"
#import "DQAnimalCoelho.h"
#import "DQAnimalLeopardinho.h"
#import "DQAnimalToupeira.h"
#import "DQIsca.h"
#import "DQJogador.h"


@interface DQArmadilhaAnimacao : SKScene

@property Boolean capturado;
@property DQAnimal *animal;
@property SKScene *cenaRetornar;
@property NSString *animacaoArmadilha;
@property SKSpriteNode *armadilha;
@property NSMutableArray *framesAnimacao;
@property SKTexture *imagemIsca;

-(id)initArmadilha: (DQArmadilha*)armadilha animal:(NSString*)nomeAnimal Isca:(DQIsca*)isca chance:(float)chance cenaRetornar:(SKScene*)cena;

@end
