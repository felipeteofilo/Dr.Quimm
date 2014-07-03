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
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 54)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 51)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
            
        case 5:
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 51)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(179,50)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(241, 231)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 238)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
            
            case 6:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 238)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(509,241)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(519, 186)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 185)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;

        case 7:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 185)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(536,185)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(538, 54)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 56)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
        
        case 8:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 56)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(74, 55)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(596, 84)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(568, 315)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(544, 470)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(131, 462)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(112, 502)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 505)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 535)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(136, 542)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(170, 498)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(541, 514)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(834, 512)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(966, 368)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(972, 369)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(973, 362)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 361)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
            
        case 9:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 363)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(405, 361)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(511, 412)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 389)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
            
        case 10:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 389)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(173, 358)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(410, 361)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(612, 270)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(979, 160)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 155)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
            
        case 11:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 156)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(177, 133)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(293, 140)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(441, 119)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(694, 126)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 104)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
            
        case 12:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 104)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(33, 101)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(962, 87)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 89)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 93)]];
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
            
        case 13:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 110)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(12, 245)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(716, 240)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(762, 289)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 276)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
            break;
            
        case 14:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 256)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(364, 233)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(689, 230)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 231)]];
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
    
    //Fecha o path
    CGPathCloseSubpath(path);
    
    //Cria o corpo físico e devolvo ele p quem chamou
    SKPhysicsBody *corpoFisicoRetorno=[SKPhysicsBody bodyWithEdgeLoopFromPath:path];
    
    
    return corpoFisicoRetorno;
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
