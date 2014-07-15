//
//  DQFase.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 09/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "DQJogador.h"
#import "DQPlataforma.h"
#import "DQEscalavel.h"
#import "DQControleCorpoFisico.h"
#import "DQConfiguracaoFase.h"
<<<<<<< HEAD
#import "DQHudController.h"
=======
#import "DQHud.h"
>>>>>>> FETCH_HEAD

//define as categorias de colisao
static const UInt32 JogadorCategoria = 0x1 << 0;
static const UInt32 ChaoCategoria = 0x1 << 1;
static const UInt32 PlataformaCategoria = 0x1 << 2;
static const UInt32 EscadaCategoria = 0x1 << 3;


static NSString* NomeNodePlataformas= @"NodeComPlataformas";

@interface DQFase : SKScene <SKPhysicsContactDelegate>

//Variável DQJogador - Define o jogador
@property DQJogador *jogador;


//Adicionado o node que guarda o mundo para poder manipular ele durante a cena
@property SKNode *mundo;
@property SKSpriteNode *backgroundAnterior;
@property SKSpriteNode *backgroundAtual;
@property SKSpriteNode *backgroundFuturo;

//Informações da Fase
@property int faseAtual;
@property int parteFaseAtual;
@property int nPartesFase;

//SKSpriteNode da setinha que auxilia o jogador a entender para onde ele precisa andar
@property SKSpriteNode *direcional;

//CGPoint que guarda onde a pessoa pressionou e assim descobrir se o personagem vai para a direita ou esquerda
@property CGPoint pontoDeToqueAndar;

//metodo para iniciar a fase
-(void)iniciarFase;
-(void)configuracoesFase:(int)faseAtual;
-(void)criarParteFase;
-(SKSpriteNode*)configurarBackgroundParte:(int)parte naPos:(CGPoint)posicao;


//Metodo para colocar a categoria da escada
-(void)escadaCategoria :(SKNode*)node;
//HUD com informações
<<<<<<< HEAD
@property DQHudController *hudFase;
=======
@property DQHud *hudFase;
>>>>>>> FETCH_HEAD
@end
