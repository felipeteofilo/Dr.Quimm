//
//  DQControleCorpoFisico.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 24/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleCorpoFisico.h"

@implementation DQControleCorpoFisico

+(NSArray*)configParte: (int)_parte daFase:(int)_fase{
    /*
     - Acessa o arquivo plist,
     - acessa o dicinário com as configurações da fase na posicao do array ROOT, usando o parametro _fase como ref.
     - do dicionário acessado pega o array com as partes
     */
    
    NSString *pathArquivoPlist=[[NSBundle mainBundle]pathForResource:@"ConfigFase" ofType:@"plist"];
    
    //Verifica se tem fase configurada
    if ([[NSArray arrayWithContentsOfFile:pathArquivoPlist]count]==0) {
        return nil;
    }
    
    //Verifica se a fase procurada esta dentro do limites do array
    if ((_fase-1 < 0) || (_fase-1 > [[NSArray arrayWithContentsOfFile:pathArquivoPlist]count] )) {
        return nil;
    }
    
    NSArray *configParteFase=[[[NSArray arrayWithContentsOfFile:pathArquivoPlist]objectAtIndex:_fase-1]objectForKey:@"Partes"];
    
    
    return configParteFase;
}

+(SKPhysicsBody*)criaCorpoFisicoChaoParte: (int)_parte daFase:(int)_fase{

    NSArray *configParteFase=[self configParte:_parte daFase:_fase];
    
    //Usando o array acessado anteriormente, pega o array com os cgpoints da KEY CorpoFisicoChao
    NSArray *posicoesAdd=[[configParteFase objectAtIndex:_parte-1]objectForKey:@"CorpoFisicoChao"];
    
    if ([posicoesAdd count]==0) {
        return nil;
    }else{

        SKPhysicsBody *corpoFisicoRetorno=[SKPhysicsBody bodyWithEdgeLoopFromPath:[self geraPathDeArray:posicoesAdd]];

        return corpoFisicoRetorno;
    }
}

+(CGMutablePathRef)geraPathDeArray:(NSArray*)arrayPosicoes{
    //Cria o path de acordo com os pontos configurados
    CGMutablePathRef path = CGPathCreateMutable();
    
    //Pega as coordenadas do ponto inicial do path para facilitar leitura
    CGPoint primeiroPonto=CGPointFromString([arrayPosicoes firstObject]);
    
    //Posiciona o path no ponto inicial do array
    CGPathMoveToPoint(path, NULL,primeiroPonto.x, primeiroPonto.y);
    
    for (NSString *stringPonto in arrayPosicoes){
        
        CGPoint pontoRef=CGPointFromString(stringPonto);
        
        //Para cada ponto do array eu crio uma linha que será usada no corpo físico
        CGPathAddLineToPoint(path, NULL,pontoRef.x,pontoRef.y);
    }
    
    //Fecha o path
    CGPathCloseSubpath(path);
    
    return path;
}

+(SKSpriteNode*)criarPlataformaParte: (int)_parte daFase:(int)_fase CGFrameTela:(CGRect)_rectTela{
    
    NSArray *configParteFase=[self configParte:_parte daFase:_fase];
    
    SKSpriteNode *nodeRetorno=[SKSpriteNode spriteNodeWithColor:nil size:_rectTela.size];
    
    if (!configParteFase) {
        return nil;
    }else{
        
        NSArray *plataformasConfig=[[configParteFase objectAtIndex:_parte-1]objectForKey:@"Plataformas"];
        
        //Cada obj no array plataformas é uma plataforma - Faz um for percorrendo as plataformas para pegar os pontos
        for (int i=0; i<[plataformasConfig count]; i++) {
            //A key plataforma é um array com Array de posicoes, que é passado para criar o physicsBody da plataforma
            
            SKPhysicsBody *corpoFisicoPlataforma=[SKPhysicsBody bodyWithEdgeLoopFromPath:[self geraPathDeArray:[plataformasConfig objectAtIndex:i]]];
            
            //Cria uma plataforma que futuramente será personalizada
            DQPlataforma *plataforma=[[DQPlataforma alloc]init];
            [plataforma setPhysicsBody:corpoFisicoPlataforma];
            
            [nodeRetorno addChild:plataforma];
        }
        
        
        return nodeRetorno;
    }
}



@end
