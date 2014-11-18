//
//  DQComposto.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQComposto.h"


@implementation DQComposto

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */




-(id)initComEntidadeComposto :(Composto*)composto{
    if (self = [super init]) {
        self.nome = composto.nome;
        self.imagem = composto.imagem;
        
        // self.imageView.image = [UIImage imageNamed:self.imagem];
        
        [self setFrame:CGRectMake(50, 500, 100, 100)];
        [self setUserInteractionEnabled:YES];
        
        [self setBackgroundColor:[UIColor blueColor]];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (self.info == nil) {
        self.info = [[DQTelaInfoComposto alloc]init];
        
        [self.info colocarNaPosicao:CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y - self.superview.frame.size.height *0.4) tamanho:self.superview.frame.size nomeComposto:self.nome];
        [self.superview addSubview:self.info.view];
    }
    else{
        
        [self.superview addSubview:self.info.view];
    }
}


@end
