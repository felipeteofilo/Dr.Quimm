//
//  DQUteis.m
//  Contador
//
//  Created by LEONARDO DE SOUSA MENDES on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQUteis.h"

@implementation DQUteis : NSObject

+(BOOL)string:(NSString*)strTestar contemPalavra:(NSString*)palavraProcurada{
    if ([strTestar rangeOfString:palavraProcurada].location ==NSNotFound){
        return NO;
    } else {
        return YES;
    }
}

+(float)calcularDistanciaPontos:(CGPoint)primeiroPonto ponto2:(CGPoint)segundoPonto{
    return hypotf(segundoPonto.x - primeiroPonto.x, segundoPonto.y - primeiroPonto.y);
}

+(NSMutableArray*)ordenarValores:(NSMutableArray*)array{
    
    NSSortDescriptor *crescente = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [array sortUsingDescriptors:[NSArray arrayWithObject:crescente]];
    
    return array;
}

+(BOOL)sortearChanceSim:(float)chanceSim{
    float valorSorteardo=(float)(arc4random()%100)/100;
    
    if (valorSorteardo < (chanceSim/100)) {
        return YES;
    }else{
        return NO;
    }
    
}
+(NSMutableArray*)lerFrames :(SKTextureAtlas*)pastaFrames{
    NSInteger numImagens = pastaFrames.textureNames.count;
    NSMutableArray *frames =[[NSMutableArray alloc]init];
    
    for (int i=1; i <= numImagens; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [pastaFrames textureNamed:textureName];
        [frames addObject:temp];
    }
    
    return frames;
}
+(BOOL)array:(NSArray*)array contemString:(NSString*)stringTestar{
    return [array containsObject:stringTestar];
}

@end
