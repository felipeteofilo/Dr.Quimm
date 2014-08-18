//
//  DQUtils.h
//  Contador
//
//  Created by LEONARDO DE SOUSA MENDES on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQUteis : NSObject

+(BOOL)string:(NSString*)strTestar contemPalavra:(NSString*)palavraProcurada;
+(float)calcularDistanciaPontos:(CGPoint)primeiroPonto ponto2:(CGPoint)segundoPonto;
+(NSMutableArray*)ordenarValores:(NSMutableArray*)array;
+(BOOL)sortearChanceSim:(float)chanceSim;
@end
