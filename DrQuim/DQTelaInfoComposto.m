//
//  DQTelaInfoComposto.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTelaInfoComposto.h"

@implementation DQTelaInfoComposto

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)colocarNaPosicao :(CGPoint)posicao tamanho:(CGSize)tamanho {
    
    [self setFrame:CGRectMake(posicao.x, posicao.y, tamanho.width *0.4, tamanho.height *0.35)];
    
    [self setBackgroundColor:[UIColor blackColor]];
}

@end
