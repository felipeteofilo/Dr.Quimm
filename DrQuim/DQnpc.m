//
//  DQnpc.m
//  DrQuim
//
//  Created by Julia Yamamoto on 08/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQnpc.h"

@implementation DQnpc

-(id)initComNome:(NSString *)nome
{
    self = [super self];
    if(self){
        self.nome = nome;
        
        //Configura o dicionarioDeFalas dependendo do nome atribuído a ele
    
    }
    return self;
}

-(void)criarSpriteNodeComNome:(NSString*)nome naPosicao:(CGPoint)posicao{
    
    //Inicia o sprite node com o nome da imagem
    self.spriteNode = [SKSpriteNode spriteNodeWithImageNamed:nome];
    [self.spriteNode setSize:CGSizeMake(180, 200)];
    
    //Configura o SpriteNode
    [self.spriteNode setAnchorPoint:CGPointMake(0, 0)];
    [self.spriteNode setName:nome];
    [self.spriteNode setPosition:posicao];
    [self.spriteNode setZPosition:0];
}

-(void)interagir
{
    //Verifica se está em alguma missão
        //Se sim -> Verifica a parte e o que deve dizer ou dar
        //Se não -> verifica o respeito e o que dizer dependendo dele.
}

@end
