//
//  DQTesteFala.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 07/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTesteFala.h"

@implementation DQTesteFala

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.controleDeFalas = [[DQFalasNoJogoControle alloc]initComFaseAtual:2];
        //[self falasDeAlerta:@"RadiacaoAlfa"];
        [self falasDoJogo];
    }
    return self;
}

-(void)falasDoJogo{
    SKSpriteNode *falaAtual =[self.controleDeFalas mostrarFalaComNPC:@"Maedetodos" KeyDaFala:@"Respeito0" Missao:nil Tamanho:self.size];
    falaAtual.anchorPoint = CGPointZero;
    [falaAtual setPosition:CGPointMake(self.frame.size.width*0.1, self.frame.size.height *0.75)];
    [self addChild:falaAtual];
}
-(void)falasDaMissao{
    
}
-(void)falasDeAlerta :(NSString*)keyDoAlerta{
    
    SKSpriteNode *falaAtual =[self.controleDeFalas mostrarAlertaComKey:keyDoAlerta Tamanho:self.size];
    falaAtual.anchorPoint = CGPointZero;
    [falaAtual setPosition:CGPointMake(self.frame.size.width*0.1, self.frame.size.height *0.75)];
    [self addChild:falaAtual];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if([self.controleDeFalas proximaFala]){
        if ([self.controleDeFalas.estadoFala isEqual:@"Alerta"]) {
            [self falasDeAlerta:nil];
        }
        else
            [self falasDoJogo];
        
    }
    
}



@end
