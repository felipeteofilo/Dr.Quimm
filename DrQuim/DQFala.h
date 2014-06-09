//
//  DQFala.h
//  DrQuim
//
//  Created by Júlia Yamamoto on 09/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQFala : SKNode

@property NSString *sujeito;
@property NSString *texto;
@property NSString *nomeFoto;

//init com SUJEITO que fala e TEXTO do que fala
-(id)initComSujeito: (NSString *)sujeito Texto:(NSString *)texto;

//init com SUJEITO que fala, TEXTO do que fala e NOME DA FOTO de quem fala
-(id)initComSujeito: (NSString *)sujeito Texto:(NSString *)texto NomeFoto:(NSString *)nomeFoto;

//Método de retorno void que mostra a fala na tela
-(void)desenhaNaTela;

@end
