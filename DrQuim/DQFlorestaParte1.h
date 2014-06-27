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

//Define o nome dos skNodes
static NSString* mundo=@"mundo";

@interface DQFlorestaParte1 : SKScene <SKPhysicsContactDelegate>


@property DQCutsceneControle *controleCutscenes;


//Varial Booleana para saber se esta rodando alguma cutscene
@property BOOL cutsceneEstaRodando;

//Variável DQJogador - Define o jogador
@property DQJogador *jogador;

//Varial do tipo DQGestoPulo - Define o gesto da acao pulo do jogador
@property DQGestoPulo *gestoPulo;

//Variavel que será usada para controlar em que parte da cena o jogador está
@property int parteFaseAtual;

//Adicionado o node que guarda o mundo para poder manipular ele durante a cena
@property SKNode* mundo;

//Variavel que controlará o N max de partes da Cena - Provisório
@property int nPartesCena;

@property SKSpriteNode *backgroundAnterior;
@property SKSpriteNode *backgroundAtual;
@property SKSpriteNode *backgroundFuturo;


//metodo para iniciar a fase
-(void)iniciarFase;


@end
