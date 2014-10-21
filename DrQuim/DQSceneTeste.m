//
//  DQSceneTeste.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 21/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQSceneTeste.h"

@implementation DQSceneTeste

-(id)initWithSize:(CGSize)size  {
    if (self=[super initWithSize:size]) {
        [self setBackgroundColor:[UIColor purpleColor]];
        
        //Cria um botao direcional
        DQBotaoDirecional *botaoDir=[[DQBotaoDirecional alloc]initBotao:@"testeBotao" comSel:@selector(moverPersonagem:) eDelegate:self eTamanho:CGSizeMake(100, 100)];
        
        [botaoDir setPosition:CGPointMake(100, 100)];
        [self addChild:botaoDir];
    }
    return self;
}
-(void)moverPersonagem :(NSNumber*)forca{
    NSLog(@"moveu o personagem com força= %f",[forca floatValue]);
}
@end
