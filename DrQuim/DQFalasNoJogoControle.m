//
//  DQFalasNoJogoControle.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFalasNoJogoControle.h"

@implementation DQFalasNoJogoControle

//Iniciar com a fase atual
-(id)initComFaseAtual:(int)faseAtual{
    
    if (self = [super init]) {
        //Pegamos o caminho do arquivo Plist a ser lido e iniciamos um array do arquivo Plist
        NSString *caminhoArquivo = [[NSBundle mainBundle] pathForResource:@"FalasNoJogo" ofType:@"plist"];
        NSArray *arrayFalas = [NSArray arrayWithContentsOfFile:caminhoArquivo];
        
        //Alocamos o dicionario de falas, e o iniciamos com as falas do arquivo Plist de acordo com missao atual
        self.dicionarioDeFalas = [[NSMutableDictionary alloc]init];
        self.dicionarioDeFalas = [arrayFalas objectAtIndex:faseAtual -1];
        
        //Iniciamos o araay que ira conter as falas atuais e setamos que nao ha falas ainda
        self.arrayDeFalasAtuais =[[NSArray alloc]init];
        self.falaAtual =-1;
    }
    
    return self;
}

//Mostrar Algum alerta da fase passando a key do alerta
-(SKSpriteNode*)mostrarAlertaComKey :(NSString*)key Tamanho:(CGSize)tamanho{
    self.estadoFala =@"Alerta";
    //Se iremos comecar a mostrar as falas atuais agora
    if (self.falaAtual == -1) {
        
        //Pegamos as falas atuais do dicionario de falas de acordo com a key passada e setamos a fala atual para o inicio
        self.falaAtual = 0;
        self.arrayDeFalasAtuais = [[self.dicionarioDeFalas objectForKey:@"Alertas"]objectForKey:key];
    }
    //Criamos a caixa de fala que ira ser mostrada no jogo
    self.caixaDeFala =[[DQFala alloc]initComDicionario:[self.arrayDeFalasAtuais objectAtIndex:self.falaAtual] eTamanho:tamanho];
    self.caixaDeFala.anchorPoint = CGPointZero;
    [self.caixaDeFala setPosition:CGPointMake(tamanho.width*0.1, tamanho.height *0.75)];
    
    [self.caixaDeFala setName:@"falasDoJogo"];
    
    //retornamos a caixa de fala ja feita com as falas
    return self.caixaDeFala;
}

//Mostrar fala em uma missao ou nao, passando o nome do Npc e a key da fala, e se estiver em missao a missao atual
-(SKSpriteNode*)mostrarFalaComNPC :(NSString*)npc KeyDaFala:(NSString*)keyFala Missao:(NSString*)missao Tamanho:(CGSize)tamanho {
    self.estadoFala =@"Fala";
    //Se iremos comecar a mostrar as falas atuais agora
    if (self.falaAtual == -1) {
        
        //setamos a fala atual para o inicio
        self.falaAtual = 0;
        
        //Se a key da missao passada existir, ou seja esta em missao
        if (missao != nil) {
            //Lemos o array de falas atuais do dicionario de falas de acordo com o Npc e a key da missao e fala da missao
            self.arrayDeFalasAtuais = [[[[self.dicionarioDeFalas objectForKey:@"Com Missão"]objectForKey:npc]objectForKey:missao]objectForKey:keyFala];
        }
        else
            //Se nao estiver em uma missao lemos o dicionario de falas de acordo com o npc e a key da fala
           self.arrayDeFalasAtuais = [[[self.dicionarioDeFalas objectForKey:@"Sem Missão"]objectForKey:npc]objectForKey:keyFala];
    }
    
    //Criamos a caixa de fala que ira ser mostrada no jogo
     self.caixaDeFala =[[DQFala alloc]initComDicionario:[self.arrayDeFalasAtuais objectAtIndex:self.falaAtual] eTamanho:tamanho];
    self.caixaDeFala.anchorPoint = CGPointZero;
    [self.caixaDeFala setPosition:CGPointMake(tamanho.width*0.1, tamanho.height *0.75)];
    [self.caixaDeFala setName:@"falasDoJogo"];
    
    //retornamos a caixa de fala ja feita com as falas
    return self.caixaDeFala;
}

//Metodo que retorna se pode ou nao mostrar a proxima fala
-(Boolean)proximaFala{
    //Setamos a fala atual para a proxima e removemos a caixa de falas anterior da tela
    self.falaAtual++;
    [self.caixaDeFala removeFromParent];
    //verificamos se e o fim das falas atuais e retornamos que nao ha mais falas
    if (self.falaAtual >= self.arrayDeFalasAtuais.count) {
        self.falaAtual = -1;
        return false;
    }
    //se ainda houver falas retornamos que ainda há falas a serem mostradas
    return true;
}

-(void)configurarControleSom{
    self.controleSom=[[DQControleSom alloc]initControleSom:NPC];

}
@end
