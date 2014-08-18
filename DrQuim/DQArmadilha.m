//
//  DQArmadilha.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 14/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQArmadilha.h"

@implementation DQArmadilha

-(id)initArmadilhaNome:(NSString*)nome descricao:(NSString*)descricao imagem:(NSString*)imagem fundo:(NSString*)fundo animacao:(NSString*)animacao; {
    if (self =[super initWithImageNamed:imagem]) {
        self.nome=nome;
        self.descricao=descricao;
        self.imagemFundo =fundo;
        self.animacao = animacao;
    }
    return self;
}

@end
