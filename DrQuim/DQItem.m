//
//  DQItem.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 24/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQItem.h"

@implementation DQItem

-(id)initItemNome:(NSString*)nome descricao:(NSString*)descricao categoria:(NSString*)categoria imagem:(NSString*)imagem Quantidade:(int)quantidade{
    if (self =[super initWithImageNamed:imagem]) {
        self.nome=nome;
        self.descricao=descricao;
        self.categoria=categoria;
        self.qndeItem = quantidade;
    }
    return self;
}
@end
