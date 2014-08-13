//
//  DQFlorestaParte1.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQFase.h"
#import "DQJogador.h"
#import "DQCutsceneControle.h"
#import "DQPlataforma.h"
#import "DQVila.h"


//Define o nome dos skNodes
//static NSString* mundo = @"mundo";

@interface DQFlorestaParte1 : DQFase <SKPhysicsContactDelegate>

//Variaveis booleanas para definir se fá foi ou não dito as falas in-game que são ditas apenas uma vez
@property BOOL falouRadiacaoAlpha;
@property BOOL falouRadiacaoBeta;
@property BOOL falouAtencaoAlpha;
@property BOOL falouAtencaoBeta;

//Variavel Booleana para definir se já passou o tutorial
@property BOOL mostrouTutorial;
@property BOOL executandoTutorial;

@property BOOL andouDireita;
@property BOOL andouEsquerda;
@property BOOL pulou;

//Timer que será usado para definir se precisa exibir ou ñ o tutorial;
@property (nonatomic) NSTimeInterval contadorAcao;
//Array com pontos de radiacao e Key de Falas na ordem
@property NSArray *pontosRadiacao;
@property NSArray *keyFalaPontoRadiacao;
@property NSMutableArray *boolFalouRadiacao;

@end
