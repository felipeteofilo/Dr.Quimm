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
        
        //Nao permitir interacao com o titulo
        [titulo setUserInteractionEnabled:NO];
        
        [self addChild:titulo];
    }
    return self;
}

-(void)configuraConteudoMenu{
    
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
    [self.conteudo.userData setObject:[NSNumber numberWithInt:index] forKey:@"indexOpcao"];
}

-(void)configuraMenuConfig{
    self.conteudo=[[DQMenuConfiguracao alloc]initMenu];
}

-(void)configuraMenuQuest{
    self.conteudo=[[DQMenuQuest alloc]initMenu];
}

-(void)configuraConteudoQuest:(NSDictionary*)missao{
    self.conteudo=[SKNode node];
    [self.conteudo setUserData:[NSMutableDictionary dictionaryWithDictionary:missao]];
    //[self.conteudo.userData setObject:[NSNumber numberWithInt:index] forKey:@"indexOpcao"];
}

-(void)apresentarConteudo{
    
    [self.parent addChild:self.conteudo];
}
-(void)esconderConteudo{
    [self.conteudo runAction:[SKAction fadeOutWithDuration:0.03]];
    [self.conteudo removeFromParent];
}
@end
