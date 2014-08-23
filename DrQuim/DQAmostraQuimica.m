//
//  DQAmostrasQuimicas.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQAmostraQuimica.h"

@implementation DQAmostraQuimica

-(id)initComDicionario:(NSDictionary *)dicionario
{
    if(self = [super init]){        
        //Pega as insformações do dicionario passado e armazena nos atributos
            //nome
        self.nome = [dicionario objectForKey:@"Nome"];
            //formula
        self.formula = [dicionario objectForKey:@"Formula"];
            //imagem
        
        self.imagem = [UIImage imageNamed:[dicionario objectForKey:@"Imagem"]];
            //elementos
        self.arrayDeElementos = [dicionario objectForKey:@"Elementos"];
            //atribui NAME
        self.name = self.nome;
        
        //Cria o sprite
            //Coloca imagem
        self.texture = [SKTexture textureWithImage:self.imagem];
            //Posição e tamanho
        self.anchorPoint = CGPointZero;
        self.size = CGSizeMake(116, 152);
        self.position = CGPointZero;
    }
    return self;
}
@end
