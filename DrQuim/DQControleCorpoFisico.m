//
//  DQControleCorpoFisico.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 24/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleCorpoFisico.h"

@implementation DQControleCorpoFisico

+(SKPhysicsBody*)criaCorpoFísicoBase: (int)parte {
    
    NSMutableArray *arrayPosicoes=[NSMutableArray array];
    
    
    //De acordo com a parte do background ele cria um array de CGPoints com as coordenadas
    switch (parte){
        case 1:
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 224)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(373, 187)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(376, 141)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(932, 121)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 127)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            
            break;
            
        case 2:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 127)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(606, 162)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(614, 300)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 302)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            break;
            
        case 3:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 302)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(35,304)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(41, 191)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(602, 201)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(613, 66)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(679, 53)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 53)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
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
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 51)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(179,50)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(241, 231)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 238)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
            
        default:
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 10)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023,10)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
    }
    
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

+(SKPhysicsBody*)adicionaPlataformaParte :(int)parte{
    
    NSMutableArray *arrayPosicoes=[NSMutableArray array];
    
    //De acordo com a parte do background ele cria um array de CGPoints com as coordenadas
    switch (parte){
            
        default:
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 10)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(10, 10)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(10, 0)]];
    }
    
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
@end
