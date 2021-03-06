//
//  DQArmadilha.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 14/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQArmadilha : SKSpriteNode

@property NSString *nome;
@property NSString *descricao;
@property NSString *imagemFundo;
@property NSString *animacao;

-(id)initArmadilhaNome:(NSString*)nome descricao:(NSString*)descricao imagem:(NSString*)imagem fundo:(NSString*)fundo animacao:(NSString*)animacao;

@end
