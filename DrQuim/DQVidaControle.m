//
//  DQVidaControle.m
//  DrQuim
//
//  Created by Felipe Teofilo on 28/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQVidaControle.h"

@implementation DQVidaControle

-(id)init{
    if (self = [super init]) {
        self.jogador = [DQJogador sharedJogador];
    }
    
    return self;
}


//Singleton do jogador
+(id)sharedControleVida
{
    static DQVidaControle *controleVida = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controleVida = [[self alloc]init];
    });
    
    return controleVida;
}
//funcap para aumentar a fome e a sede em relacao ao tempo
-(void)atualizarSituacaoJogador{
    if (self.inicioContador == 0) {
        self.inicioContador = CACurrentMediaTime();
        
    }
    if (CACurrentMediaTime()-self.inicioContador > 10) {
        if (self.jogador.fome > 0) {
            [self.jogador aumentarFome:1];
        }
        if (self.jogador.sede > 0) {
            [self.jogador aumentarSede:2];
        }
        if (self.jogador.vida > 0 && self.jogador.fome <= 0 && self.jogador.sede <= 0) {
            [self.jogador perderVida:1];
        }
        self.inicioContador = CACurrentMediaTime();
    }
}



@end
