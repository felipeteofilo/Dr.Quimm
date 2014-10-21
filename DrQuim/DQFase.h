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
#import "DQHudController.h"
#import "DQCoberturaBackground.h"
#import "DQMenu.h"
#import "DQControleUserDefalts.h"
#import "DQCutsceneTela.h"
#import "DQVidaControle.h"
#import "DQFalasNoJogoControle.h"
#import "DQControleSomScene.h"

#import "DQCoreDataController.h"
#import "DQBotaoDirecional.h"



//define as categorias de colisao
static const UInt32 JogadorCategoria = 0x1 << 0;
static const UInt32 ChaoCategoria = 0x1 << 1;
static const UInt32 PlataformaCategoria = 0x1 << 2;
static const UInt32 EscadaCategoria = 0x1 << 3;

static NSString* NomeNodePlataformas= @"NodeComPlataformas";

@interface DQFase : SKScene <SKPhysicsContactDelegate>

//Variável DQJogador - Define o jogador
@property DQJogador *jogador;

//DQFalasNoJogoControle para controlar as falas do jogo
@property DQFalasNoJogoControle *controleDeFalas;

//DQCutsceneControle para apresentar alguma cutscene
@property DQCutsceneTela *cutscene;

//DQVidaControle para controlar a vida do personagem
@property DQVidaControle *controladorDaVida;


//Adicionado o node que guarda o mundo para poder manipular ele durante a cena
@property SKNode *mundo;
@property SKSpriteNode *backgroundAnterior;
@property SKSpriteNode *backgroundAtual;
@property SKSpriteNode *backgroundFuturo;

//Informações da Fase
@property int faseAtual;
@property int parteFaseAtual;
@property int nPartesFase;

//Removido pois terá um botao exclusivo
////SKSpriteNode da setinha que auxilia o jogador a entender para onde ele precisa andar
//@property SKSpriteNode *direcional;

//CGPoint que guarda onde a pessoa pressionou e assim descobrir se o personagem vai para a direita ou esquerda
@property CGPoint pontoDeToqueAndar;

//HUD com informações
@property DQHudController *hudFase;

//Propriedade que será usada para guardar as configs da fase e nao ficar travando ao ler o plist
@property NSDictionary *configFase;

@property (nonatomic) NSTimeInterval intervaloUltimoUpdate;
@property BOOL jogoPausado;

//Sera usado para sons
@property DQControleSomScene *controleSom;

//Controles
@property DQBotaoDirecional *direcional;

//metodo para iniciar a fase
-(void)iniciarFase;
-(id)initFase:(int)fase Size:(CGSize)size;
-(void)configuracoesFase:(int)faseAtual;
-(void)criarParteFase;
-(SKSpriteNode*)configurarBackgroundParte:(int)parte naPos:(CGPoint)posicao;

-(void)escadaCategoria :(SKNode*)node;
-(void)criaJogador;
@end
