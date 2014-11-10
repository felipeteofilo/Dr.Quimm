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
        
        self.imageView.image = [UIImage imageNamed:self.imagem];
        
        //self.arrayElementos = composto.arrayElementos;
        
        NSLog(@"foi la");
    }
    return self;
}


@end
