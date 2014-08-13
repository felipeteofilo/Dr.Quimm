//
//  DQVidaControle.h
//  DrQuim
//
//  Created by Felipe Teofilo on 28/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQJogador.h"

@interface DQVidaControle : NSObject

@property DQJogador *jogador;

@property CFTimeInterval inicioContador;

//funcao para aumentar a fome e a sede em relacao ao tempo
-(void)atualizarSituacaoJogador;

//Singleton do controlador de vida
+(id)sharedControleVida;

@end
