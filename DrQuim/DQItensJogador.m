//
//  DQItensJogador.m
//  DrQuim
//
//  Created by Julia Yamamoto on 21/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQItensJogador.h"

@implementation DQItensJogador

-(id)init
{
    self = [super init];
    if(self){
        
        
        //dicionario
        self.dicionarioDeItensJogador = [[NSMutableDictionary alloc]init];
        
        
        //Popula o dicionario que descreve os itens
        //url
        NSString *urlItensReferencia = [[NSBundle mainBundle] pathForResource:@"ItensReferencia" ofType:@"plist"];
        //dicionario
        self.dicionarioDeItensReferencia = [[NSMutableDictionary alloc]initWithContentsOfFile:urlItensReferencia];
        
        
    }
    return self;
}

//Método que adiciona um item ao jogador
-(void)receberItem: (NSString *)item quantidade:(int)quantidade;
{
    int quantidadeFinal = quantidade;
    
    //Soma a quantidade á quantidadeAtual
    
    if ([self.dicionarioDeItensJogador objectForKey:item]) {
        int quantidadeAtual = [[self.dicionarioDeItensJogador objectForKey:item] intValue];
        quantidadeFinal = quantidadeAtual + quantidade;
    }
    
    
    //escrever no dicionario a nova quantidade e o item
    [self.dicionarioDeItensJogador setObject:[NSNumber numberWithInt:quantidadeFinal] forKey:item];
}

//Método que tira um item do jogador
-(void)entregarItem: (NSString *)item quantidade:(int)quantidade;
{
    //Subtrai a quantidade á quantidadeAtual
    int quantidadeAtual = [[self.dicionarioDeItensJogador objectForKey:item] intValue];
    int quantidadeFinal = quantidadeAtual - quantidade;
    
    //escrever no dicionario de itens jogador
    [self.dicionarioDeItensJogador setValue:[NSNumber numberWithInt:quantidadeFinal] forKey:item];
    
    if ([[self.dicionarioDeItensJogador valueForKey:item]intValue] <= 0) {
        [self.dicionarioDeItensJogador removeObjectForKey:item];
    }
}

-(void)mostrarItens
{
    //Armazena todas as keys do dicionario de itens em um array
    NSArray *arrayDeKeysDeItens = [[NSArray alloc] initWithArray:[self.dicionarioDeItensJogador allKeys]];
    
    //A partir de cada Key, mostra: Nome, Descrição, Categoria, Quantidade e Imagem
    for(int i = 0; i < [arrayDeKeysDeItens count]; i++){
        //Pega a key
        NSString *keyTemporaria = [arrayDeKeysDeItens objectAtIndex:i];
        
        //Pega o nome
        NSString *nomeTemporario = [[self.dicionarioDeItensReferencia objectForKey:keyTemporaria] objectForKey:@"nome"];
        //Pega a descricao
        NSString *descricaoTemporaria = [[self.dicionarioDeItensReferencia objectForKey:keyTemporaria] objectForKey:@"descricao"];
        //Pega a categoria
        NSString *categoriaTemporaria = [[self.dicionarioDeItensReferencia objectForKey:keyTemporaria] objectForKey:@"categoria"];
        //Pega a quantidade
        int quantidadeTemporaria = [[self.dicionarioDeItensJogador objectForKey:keyTemporaria]intValue];
        //Pega a imagem
        NSString *imagemTemporaria = [[self.dicionarioDeItensReferencia objectForKey:keyTemporaria] objectForKey:@"imagem"];
        
        //Mostra tudo
        NSLog(@"Nome: %@| Descrição: %@| Categoria: %@| Quantidade: %i| Imagem: %@", nomeTemporario, descricaoTemporaria, categoriaTemporaria, quantidadeTemporaria, imagemTemporaria);
        
        //Mostra nome e quatidade apenas
        NSLog(@"%@ = %i unidades", nomeTemporario,  quantidadeTemporaria );
    }
}

-(NSArray*)arrayItensJogador{
    NSArray *arrayRetorno=[[NSArray alloc]initWithArray:[self.dicionarioDeItensJogador allKeys]];
    
    return arrayRetorno;
}

@end
