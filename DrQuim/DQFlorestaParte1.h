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

//Define o nome dos skNodes de background
static NSString* backgroundAtual=@"backgroundAtualCena";
static NSString* proxBackground=@"proxBackgroundCena";
static NSString* backgroundAnt=@"backgroundAntCena";
static NSString* nomeMundo=@"mundo";

@interface DQFlorestaParte1 : SKScene <SKPhysicsContactDelegate>


@property DQCutsceneControle *controleCutscenes;

//Seletor para iniciar fase
@property BOOL cutsceneEstaRodando;

//Variável DQJogador - Define o jogador
@property DQJogador *jogador;

//Varial do tipo DQGestoPulo - Define o gesto da acao pulo do jogador
@property DQGestoPulo *gestoPulo;

//Variavel que será usada para controlar a posicao em X do jogador- em relação ao tamanho da skScene
@property float posicaoXJogador;

//Variavel que controlará a ultima posicao de X de uma parte da fase
@property float ultimoXParteFase;

//Variavel que será usada para controlar em que parte da cena o jogador está
@property int parteFaseAtual;

//Adicionado o node que guarda o mundo para poder manipular ele durante a cena
@property SKNode* mundo;

//Variavel que controlará o N max de partes da Cena - Provisório
@property int nPartesCena;

//metodo para iniciar a fase
-(void)iniciarFase;

//Variavel que será usada para controlar quanto tempo se passou desde o ultimo update
//@property (nonatomic) NSTimeInterval intervaloUltimoUpdate;
//@property (nonatomic) NSTimeInterval tempoDesdeUltimoUpdate;

@end
