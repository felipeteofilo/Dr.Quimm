//
//  DQMenuArmadilhas.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 14/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQProtocolMenu.h"
#import "DQJogador.h"
#import "DQArmadilha.h"
#import "DQItem.h"
#import "DQArmadilhaAnimacao.h"



@interface DQMenuArmadilhas : SKSpriteNode<DQProtocolMenu>

@property DQJogador *jogador;

@property NSString *chanceAtual;
@property NSString *animalAtual;
@property DQArmadilha *armadilhaSelecionada;
@property int parteAtual;

@property NSMutableDictionary *lugaresArmados;

@property SKLabelNode *titulo;

@property NSArray *armadilhas;
@property NSArray *itens;
@property int itensLinha;
@property int itensColuna;

@end
