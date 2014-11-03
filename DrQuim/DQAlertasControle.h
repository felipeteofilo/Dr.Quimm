//
//  DQAlertasControle.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 28/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "DQConfiguracaoFase.h"

@interface DQAlertasControle : NSObject


@property NSArray *arquivo;
@property NSMutableDictionary *falouAlerta;
@property NSDictionary *alertaAtual;
@property Boolean podeMudar;

-(id)initComFaseAtual :(int)fase;
-(void)atualizarAlerta :(SKScene*)cena;
-(void)verificarAlerta :(CGPoint)pontoJogador fase:(SKScene*)cena;


@end
