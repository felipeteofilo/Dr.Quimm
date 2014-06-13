//
//  DQFala.h
//  DrQuim
//
//  Created by Júlia Yamamoto on 09/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQFala : SKSpriteNode

@property NSString *sujeito;
@property NSString *texto;

//init com SUJEITO que fala e TEXTO do que fala
-(id)initComSujeito: (NSString *)sujeito_ Texto:(NSString *)texto_;

//EXCLUSIVAMENTE PARA TESTES!
//Método de retorno void - Mostra as falas dos personagens
-(void)desenhaNaTela;

@end
