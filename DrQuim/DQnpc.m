//
//  DQNpc.m
//  DrQuim
//
//  Created by Julia Yamamoto on 08/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQNpc.h"

@implementation DQNpc

-(id)initComNome:(NSString *)nome naPosicao:(CGPoint)posicao
{
    //Inicia o sprite node com o nome da imagem
    self = [super initWithImageNamed:nome];
    if(self){
        
        //Configura o SpriteNode
        if ([nome isEqual:@"Quimm"]) {
            [self setSize:CGSizeMake(120, 120)];
        }
        else{
            [self setSize:CGSizeMake(180, 180)];
        }
        [self setAnchorPoint:CGPointMake(0, 0)];
        [self setName:nome];
        [self setPosition:posicao];
        [self setZPosition:0];
        
        self.name = nome;
        
        NSMutableDictionary * tipo = [[NSMutableDictionary alloc]init];
        
        [tipo setObject:@"NPC" forKey:@"Tipo"];
        
        [self setUserData:tipo];
        
        //[self setUserInteractionEnabled:YES];
    
    }
    return self;
}

@end
