//
//  DQReceita.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQReceita.h"

@implementation DQReceita

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initComNome:(Receita*)receita{
    if (self = [super init]) {
        self.nome = receita.nome;
        self.imageView.image = [UIImage imageNamed:@"imagemReceita"];
        [self setTitle:self.nome forState:UIControlStateNormal];
        
        self.descricao = receita.descricao;
        
    }
    return self;
}

-(void)iniciarCompostos{
    
}

@end
