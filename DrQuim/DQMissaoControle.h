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

@interface DQMissaoControle : NSObject

@property DQMissao *missao;
@property int parteAtual;
@property BOOL emMissao;
@property SKScene *cena;

-(id)initCena:(SKScene*)cena;

-(BOOL)iniciarNovaMissaoNPC:(NSString*)NPC;

-(BOOL)passarParteMissao:(NSString*)NPC item:(NSString*)item;
-(void)entregarItem;
-(void)receberItem;
-(void)receberEstados;
-(void)fimDaMissao;
@end
