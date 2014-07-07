//
//  DQControleCorpoFisico.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 24/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleCorpoFisico.h"

@implementation DQControleCorpoFisico



+(SKPhysicsBody*)criaCorpoFisicoChaoParte: (int)_parte daFase:(int)_fase{
    
    NSArray *configParteFase=[DQConfiguracaoFase configParte:_parte daFase:_fase];
    
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
    
    NSArray *configParteFase=[DQConfiguracaoFase configParte:_parte daFase:_fase];
    
    SKSpriteNode *nodeRetorno;
    
    if (!configParteFase) {
        return nil;
    }else{
        
        NSArray *plataformasConfig=[[configParteFase objectAtIndex:_parte-1]objectForKey:@"Plataformas"];
        
        if ([plataformasConfig count]!=0) {
            nodeRetorno=[SKSpriteNode spriteNodeWithColor:nil size:_rectTela.size];
        }
        
        //Cada obj no array plataformas é uma plataforma - Faz um for percorrendo as plataformas para pegar os pontos
        for (int i=0; i<[plataformasConfig count]; i++) {
            //A key plataforma é um array com Array de posicoes, que é passado para criar o physicsBody da plataforma
            
            CGPathRef pathConfgigurado=[self geraPathDeArray:[plataformasConfig objectAtIndex:i]];
            SKPhysicsBody *corpoFisicoPlataforma=[SKPhysicsBody bodyWithEdgeLoopFromPath:pathConfgigurado];
        
            DQPlataforma *plataforma=[[DQPlataforma alloc]initComY:CGRectGetMaxY(CGPathGetBoundingBox(pathConfgigurado))];
            [plataforma setPhysicsBody:corpoFisicoPlataforma];
            
            [nodeRetorno addChild:plataforma];
            
        }
        
        
        return nodeRetorno;
    }
}

@end