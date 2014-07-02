//
//  DQIntroducao.h
//  Dr.Quimm2
//
//  Created by Julia Yamamoto on 02/07/14.
//  Copyright (c) 2014 Júlia Yamamoto. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQJogador.h"
#import "DQGestoPulo.h"
#import "DQCutscene.h"
#import "DQControleCorpoFisico.h"

//* STATICs *\\

//Define o nome dos SKNodes de background
static NSString* backgroundAtual = @"backgroundAtualCena";
static NSString* proxBackground = @"proxBackgroundCena";
static NSString* backgroundAnt = @"backgroundAntCena";
static NSString* backgroundEliminar = @"backEliminar";
static NSString* mundo = @"mundo";

//Define as categorias de colisao
static const UInt32 JogadorCategoria = 0x1 << 1;
static const UInt32 ChaoCategoria =0x1 << 2;
//*** FIM ***\\


@interface DQIntroducao : SKScene <SKPhysicsContactDelegate>

//DQCutScenes das cutscenes
@property DQCutscene *primeiraCutscene;
@property DQCutscene *segundaCutScene;

//Booleano para saber se está no meio de uma cutscene
@property BOOL cutsceneEstaRodando;

//Booleano para saber se está no meio de uma fala in-game
@property BOOL alguemEstaFalando;

//SKNode que controla o 'mundo' dessa fase
@property SKNode *mundo;

//DQJogador que define o jogador dessa fase
@property DQJogador *jogador;

//Inteiro usado para controlar em que parte da cena o jogador está
@property int parteFaseAtual;

//float que controla a ultima posicao X de uma parte da fase
@property float ultimoXParteFase;

//Guarda quantas partes a fase atual tem
@property int partesFase;

@property DQGestoPulo *gestoPulo;

//Método que inicia a classe
-(id)initWithSize:(CGSize)size;

//********************************************COISAS A FAZER - LINHA 8!!!
//Método que inicia uma das cutscenes da cena, passada por paramentro
-(void)iniciarCutSceneParte:(int)parte;

//Método que inicia a fase
-(void)iniciarFase;

//Método que cria e incia todas as partes da fase
-(void)criaPartesFase;

//Metodo que controle em que parte da fase está e carrega as necessárias
-(void)controlaParteFase;


@end


