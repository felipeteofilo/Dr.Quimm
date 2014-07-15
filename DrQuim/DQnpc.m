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
        
<<<<<<< HEAD
        //CONFIGURA O DICIONARIO DE FALAS DEPENDENDO DO NOME ATRIBUÍDO A ELE.
            //Armazena a url do arquivo "FalasNoJogo.plist"
        NSString *url = [[NSBundle mainBundle]pathForResource:@"FalasNoJogo" ofType:@"plist"];
            //Armazena o conteúdo do array de "FalasNoJogo.plist"
        NSArray *arrayFalas = [[NSArray alloc] initWithContentsOfFile:url];
            //Armazena as falas da vila - De todos os personagens
        NSDictionary *falasDaVila = [[NSDictionary alloc]initWithDictionary:[[arrayFalas objectAtIndex:1] objectForKey:@"Falas"]];
            //Dependendo do nome, recebe seu Dicionario de Falas:
        self.dicionarioDeFalas = [[NSDictionary alloc]initWithDictionary:[falasDaVila objectForKey:nome]];
        
        //DIVIDE O DICIONARIO EM OUTRAS PARTES - COM MISSÃO, MISSÃO01,...
            //sem missão
            self.dicionarioDeFalasSemMissao = [[NSDictionary alloc]initWithDictionary:[self.dicionarioDeFalas objectForKey:@"SemMissao"]];
            //missão01
            self.dicionarioDeFalasMissao01 = [[NSDictionary alloc]initWithDictionary:[self.dicionarioDeFalas objectForKey:@"Missao01"]];
=======
        //Configura o dicionarioDeFalas dependendo do nome atribuído a ele
    
>>>>>>> FETCH_HEAD
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

<<<<<<< HEAD
-(void)interagirSemMissao: (int)respeito;
=======
-(void)interagir
>>>>>>> FETCH_HEAD
{
    //Verifica se está em alguma missão
        //Se sim -> Verifica a parte e o que deve dizer ou dar
        //Se não -> verifica o respeito e o que dizer dependendo dele.
}

@end
