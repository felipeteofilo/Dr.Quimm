//
//  DQFlorestaParte1.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQJogador.h"
#import "DQCutsceneControle.h"


//define as categorias de colisao
static const UInt32 JogadorCategoria = 0x1 << 1;
static const UInt32 ChaoCategoria = 0x1 << 2;

//Define o nome dos skNodes
static NSString* mundo = @"mundo";

@interface DQFlorestaParte1 : SKScene <SKPhysicsContactDelegate>

@property DQCutsceneControle *controleCutscenes;

//Variavel Booleana para saber se esta rodando alguma cutscene
@property BOOL cutsceneEstaRodando;
@property BOOL estaFalando;

//Variaveis booleanas para definir se fá foi ou não dito as falas in-game que são ditas apenas uma vez
@property BOOL falouRadiacaoAlpha;
@property BOOL falouRadiacaoBeta;

//Variável DQJogador - Define o jogador
@property DQJogador *jogador;

//SKSpriteNode da setinha que auxilia o jogador a entender para onde ele precisa andar
@property SKSpriteNode *setinhas;

//CGPoint que guarda onde a pessoa pressionou e assim descobrir se o personagem vai para a direita ou esquerda
@property CGPoint pontoDeToqueAndar;

//Variavel que será usada para controlar em que parte da cena o jogador está
@property int parteFaseAtual;

//@Variavel que guardará a fase atual
@property int faseAtual;

//Adicionado o node que guarda o mundo para poder manipular ele durante a cena
@property SKNode* mundo;

@property SKSpriteNode *backgroundAnterior;
@property SKSpriteNode *backgroundAtual;
@property SKSpriteNode *backgroundFuturo;

//Variavel que controlará o N max de partes da Cena - Provisório
@property int nPartesCena;

//metodo para iniciar a fase
-(void)iniciarFase;


@end
