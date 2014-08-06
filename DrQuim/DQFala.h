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
@property NSString *foto;

-(id)initComDicionario: (NSDictionary *)dicionarioDaFala;


//TEMPORÁRIO - APENAS PARA NÃO DAR ERRO
-(id)initComSujeito:sujeitoTemporario Texto:textoTemporario;


@end
