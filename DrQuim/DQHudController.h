//
//  DQHudController.h
//  TesteBarraStatus
//
//  Created by Leonardo de Sousa Mendes on 14/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQJogador.h"
#import "DQBarraStatus.h"

@interface DQHudController : SKSpriteNode

@property DQBarraStatus *barraVida;
@property DQBarraStatus *barraSede;
@property DQBarraStatus *barraFome;

-(id)initHud;
-(void)atualizarHud;
-(void)atualizarBarraStatus;
-(void)esconderHud;
-(void)mostrarHud;
@end
