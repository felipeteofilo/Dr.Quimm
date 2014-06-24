//
//  DQFlorestaParte1.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQJogador.h"
#import "DQGestoPulo.h"
#import "DQCutsceneControle.h"


//define as categorias de colisao
static const UInt32 JogadorCategoria = 0x1 << 1;
static const UInt32 ChaoCategoria =0x1 << 2;

@interface DQFlorestaParte1 : SKScene <SKPhysicsContactDelegate>

//Variável DQJogador - Define o jogador
@property DQJogador *jogador;

//Variavel do tipo DQGestoPulo - Define o gesto da acao pulo do jogador
@property DQGestoPulo *gestoPulo;

//Variavel que será usada oara

@end
