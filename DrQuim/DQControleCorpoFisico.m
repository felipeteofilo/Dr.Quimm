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
    
    NSString *pathArquivoPlist=[[NSBundle mainBundle]pathForResource:@"ConfigFase" ofType:@"plist"];
    
    /*
     - Acessa o arquivo plist,
        - acessa o dicinário com as configurações da fase na posicao do array ROOT, usando o parametro _fase como ref.
            - do dicionário acessado pega o array com as partes
     */
    NSArray *configParteFase=[[[NSArray arrayWithContentsOfFile:pathArquivoPlist]objectAtIndex:_fase-1]objectForKey:@"Partes"];
    
    //Usando o array acessado anteriormente, pega o array com os cgpoints da KEY CorpoFisicoChao
    NSArray *posicoesAdd=[[configParteFase objectAtIndex:_parte-1]objectForKey:@"CorpoFisicoChao"];
    
    if ([posicoesAdd count]==0) {
        return nil;
    }else{
        
        //Cria o path de acordo com os pontos configurados
        CGMutablePathRef path = CGPathCreateMutable();
        
        //Pega as coordenadas do ponto inicial do path para facilitar leitura
        //CGPoint primeiroPonto=[[posicoesAdd firstObject]CGPointValue];
        CGPoint primeiroPonto=CGPointFromString([posicoesAdd firstObject]);
        
        //Posiciona o path no ponto inicial do array
        CGPathMoveToPoint(path, NULL,primeiroPonto.x, primeiroPonto.y);
        
        for (NSString *stringPonto in posicoesAdd){
            
            CGPoint pontoRef=CGPointFromString(stringPonto);
            
            //Para cada ponto do array eu crio uma linha que será usada no corpo físico
            CGPathAddLineToPoint(path, NULL,pontoRef.x,pontoRef.y);
        }
        
        //Fecha o path
        CGPathCloseSubpath(path);
        
        //Cria o corpo físico e devolvo ele p quem chamou
        SKPhysicsBody *corpoFisicoRetorno=[SKPhysicsBody bodyWithEdgeLoopFromPath:path];
        
        
        return corpoFisicoRetorno;
    }
}

+(SKPhysicsBody*)adicionaPlataformaParte :(int)parte{
    
    NSMutableArray *arrayPosicoes=[NSMutableArray array];
    
    //De acordo com a parte do background ele cria um array de CGPoints com as coordenadas
    switch (parte){
        case 3:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(665, 303)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(661, 326)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(922, 342)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(920, 435)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 435)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 412)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(954, 411)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(958, 327)]];
            
            break;
            
        case 4:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 411)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 434)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(539, 438)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(558, 388)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 367)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 343)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(541, 358)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(516, 409)]];
            
            break;
            
        case 5:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 344)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(114, 341)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(113, 364)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 370)]];
            
            break;
            
        case 7:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(504, 297)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(827, 290)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(837, 321)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(511, 322)]];
            
            break;
            
        case 8:
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(141, 653)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(371, 654)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(371, 687)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(141, 683)]];
            
            break;
    }
    
    //Se nao gerou path e porque nao tem plataforma
    if ([arrayPosicoes count]==0) {
        return nil;

    }else{
        //Cria o path de acordo com os pontos configurados
        CGMutablePathRef path = CGPathCreateMutable();
        
        //Pega as coordenadas do ponto inicial do path para facilitar leitura
        CGPoint primeiroPonto=[[arrayPosicoes firstObject]CGPointValue];
        
        //Posiciona o path no ponto inicial do array
        CGPathMoveToPoint(path, NULL,primeiroPonto.x, primeiroPonto.y);
        
        for (NSValue *pontoMapa in arrayPosicoes){
            //Para cada ponto do array eu crio uma linha que será usada no corpo físico
            CGPathAddLineToPoint(path, NULL,[pontoMapa CGPointValue].x,[pontoMapa CGPointValue].y);
        }
        
        //Fecho o path
        CGPathCloseSubpath(path);
        
        //Crio o corpo físico e devolvo ele p quem chamou
        SKPhysicsBody *corpoFisicoRetorno=[SKPhysicsBody bodyWithEdgeLoopFromPath:path];
        
        
        return corpoFisicoRetorno;
    }
}

+(SKPhysicsBody*)criaPlataformaExtra:(int)parteCena{
    CGMutablePathRef path = CGPathCreateMutable();
    
    if (parteCena==7) {
        
        CGPathMoveToPoint(path, NULL, 752, 499);
        CGPathAddLineToPoint(path, NULL, 756, 522);
        CGPathAddLineToPoint(path, NULL, 1023, 536);
        CGPathAddLineToPoint(path, NULL, 1023, 504);
        
        CGPathCloseSubpath(path);
        
        return [SKPhysicsBody bodyWithEdgeLoopFromPath:path];
    }else{
        return nil;
    }
}

@end
