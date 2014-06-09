//
//  DQControleTela.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 29/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleTela.h"

@implementation DQControleTela


+(UIImage *)imagemTela:(int)idTela{
    
    UIImage *imagemRetorno=[[UIImage alloc]init];

    switch (idTela) {
        case 1:
            
            imagemRetorno=[UIImage imageNamed:@"cenaTeste1"];
            break;
            
        default:
            imagemRetorno=[UIImage imageNamed:@"imagemTestePadrao"];
            break;
    }
    
    return imagemRetorno;
}

+(NSArray *)falasTela:(int)idTela{
    
    NSArray *falasRetorno;
    
    switch (idTela) {
        case 1:
            //falasRetorno=[self falasTela1];
            break;
            
        default:
            falasRetorno =nil;
            break;
    }
    
    return falasRetorno;
}


//+(NSArray*)falasTela1{
//    
//    NSMutableArray *arrayRetorno=[NSMutableArray array];
//    
//    //Usando NSValue pois o mutable array exige um objeto, quando for pegar as posicoes usar o método [p... CGPoitValue]
//    NSValue *posFalaPiloto=[NSValue valueWithCGPoint:CGPointMake(50, 500)];
//    NSValue *posFalaCients=[NSValue valueWithCGPoint:CGPointMake(300, 50)];
//    
//    //A posicao adicionada indicara que as proximas string são do piloto ou do cientista
//    [arrayRetorno addObject:posFalaPiloto];
//    NSString *falaPiloto=@"uau! um dos maiores cientistas do mundo está no meu helicóptero... Preciso falar algo...";
//    [arrayRetorno addObject:falaPiloto];
//    
//    falaPiloto=@" ... ";
//    [arrayRetorno addObject:falaPiloto];
//    
//    falaPiloto=@"*emoticonEnvergonhado*";
//    [arrayRetorno addObject:falaPiloto];
//    
//    falaPiloto=@"hmm... bonito o jaleco do senhor.";
//    [arrayRetorno addObject:falaPiloto];
//    
//    
//    [arrayRetorno addObject:posFalaCients];
//    
//    NSString *falaCientista=@"*emoticonIndiferente*";
//}
/*
Cientista (indiferente): é algodão egípcio
Piloto (animado): que legal! onde o senhor conseguiu?
Cientista (indiferente): Egito.
< silêncio por um tempo >
Piloto: Mas porque alguém como o senhor está indo para uma ilha como aquela? Meu primo, ele é marinheiro, ele disse que uma vez viu monstros naquela ilha.
Cientista, (risadaIrônica): Tenho um trabalho a fazer.
Piloto: Entendo... que trabalho é esse?
Cientista: Coleta de amostras
Piloto: Amostras... legal! De que?
Cientista: Material radioativo.
Piloto, virando (assustado): radioativo?

<Quando vira, algo passa pelas janelas, começa a tremer e uma luz vermelha fica piscando.>

Cientista: Pela barbas de darwin! O que foi aquilo?
Piloto: Precisamos sair daqui.
    
}
 */
@end
