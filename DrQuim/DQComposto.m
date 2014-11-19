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




-(id)initComEntidadeComposto :(Composto*)composto :(CGRect)frame{
    if (self = [super init]) {
        
        
        
        self.frame = frame;
        
        //Mudar abaixo para colocar o nome do recipiente e adiquirir sua imagem
        UIImageView *imagemDoComposto = [[UIImageView alloc]initWithImage:[UIImage imageNamed:composto.imagem]];
        
        imagemDoComposto.frame = CGRectMake(self.frame.size.width/2 - (self.frame.size.height * 0.15)/2,
                                            self.frame.size.height * 0.15 - (self.frame.size.height * 0.15)/2,
                                            self.frame.size.height * 0.35,
                                            self.frame.size.height * 0.35);
        
        imagemDoComposto.layer.zPosition = -10;
        [self addSubview:imagemDoComposto];
        
        self.nome = composto.nome;
        self.imagem = composto.imagem;
        [self setUserInteractionEnabled:YES];
        
       
    }
    return self;
}

-(void)mostrarInfoComposto :(UIView*)view{
    
    NSArray *views = [self.superview subviews];
    for(int i = 0; i < views.count ;i++){
        if([[views objectAtIndex:i]tag] == 100) {
            [[views objectAtIndex:i]removeFromSuperview];
            break;
        }
    }
    
    
    if (self.info == nil) {
        self.info = [[DQTelaInfoComposto alloc]init];
        
        [self.info colocarNaPosicao:CGPointMake(view.frame.size.width *0.7, 0) tamanho:view.frame.size nomeComposto:self.nome];
        
        self.info.view.tag = 100;
        [view addSubview:self.info.view];
        
        
    }
//    else{
//        
//       [view addSubview:self.info.view];
//    }
}


@end
