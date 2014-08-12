//
//  DQOpcaoMenu.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 25/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQOpcaoMenu.h"

@implementation DQOpcaoMenu

-(id)initOpcaoTitulo:(NSString*)titulo{
    if (self=[super initWithImageNamed:@"FundoOpcao.png"]) {
        self.titulo=titulo;
        
        SKLabelNode *titulo=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
        [titulo setText:self.titulo];
        [titulo setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)+60)];
        
        [self addChild:titulo];
    }
    return self;
}

-(void)configuraConteudoMenuIndex:(int)index{
    
    switch ([[DQConfigMenu opcoesMenuPrincial] indexOfObject:self.titulo]) {
        case 0:
            [self configuraMenuItens];
            break;
            
        case 1:
            [self configuraMenuQuest];
            break;
            
        case 2:
            [self configuraMenuLivro];
            break;
            
        case 3:
            [self configuraMenuConfig];
            break;
            
        default:
            break;
    }
    
    NSMutableDictionary *dicionario=[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:index] forKey:@"index"];
    
    [self.conteudo setUserData:dicionario];
}

-(void)configuraMenuItens{
    self.conteudo=[[DQMenuItem alloc]initMenu];
}

-(void)configuraMenuLivro{
    self.conteudo=[[DQMenuReceita alloc]initMenu];
}
-(void)configuraConteudoReceita:(NSDictionary*)receita index:(int)index{
    self.conteudo=[SKNode node];
    [self.conteudo setUserData:[NSMutableDictionary dictionaryWithDictionary:receita]];
    [self.conteudo.userData setObject:[NSNumber numberWithInt:index] forKey:@"index"];
}

-(void)configuraMenuConfig{
    self.conteudo=[[DQMenuConfiguracao alloc]initMenu];
}

-(void)configuraMenuQuest{
    self.conteudo=[[DQMenuQuest alloc]initMenu];
}

-(void)configuraConteudoQuest:(NSDictionary*)missao  index:(int)index{
    self.conteudo=[SKNode node];
    [self.conteudo setUserData:[NSMutableDictionary dictionaryWithDictionary:missao]];
    [self.conteudo.userData setObject:[NSNumber numberWithInt:index] forKey:@"index"];
}

-(void)apresentarConteudo{
    [self.parent addChild:self.conteudo];
}
-(void)esconderConteudo{
    [self.conteudo removeFromParent];
}
@end
