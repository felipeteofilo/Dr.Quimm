//
//  DQMissaoControle.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import "DQMissao.h"

//#import "DQVidaControle.h"

@interface DQMissaoControle : NSObject

@property DQMissao *missao;
@property int parteAtual;
@property int proximaMissao;
@property BOOL emMissao;
@property SKScene *cena;

@property SKSpriteNode *balao;

//Método INIT, Inicia com a cena em que a missão está acontecendo
-(id)initCena:(SKScene *)cena;

//Méotodo chamado quando o jogador não está em uma missão - avalia se uma irá começar
-(BOOL)iniciarNovaMissaoNPC:(NSString *)NPC;

//Método chamado quando o jogador está em uma missão - avalia se irá passar de parte ou acabar
-(BOOL)passarParteMissao:(NSString *)NPC inventario:(NSArray*)items;

//Funcao para atualizar a cena da classe
-(void)atualizarCena :(SKScene*)cenaRecebida;

//Coloca o balao em cima do personagem
-(void)colocarBalaoDeMissao;

@end
