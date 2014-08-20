//
//  DQAmostrasQuimicas.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQAmostraQuimica : SKSpriteNode

//Define o nome da amostra
@property NSString *nome;

//Define a formula da amostra
@property NSString *formula;

//Define a imagem do spriteNode
@property UIImage *imagem;

//NSArray que armazena os elementos da amostra
@property NSArray *arrayDeElementos;

//Método INIT que recebe um dicionario com as informações da amostra
-(id)initComDicionario: (NSDictionary *)dicionario;

@end
