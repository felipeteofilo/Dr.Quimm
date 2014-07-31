//
//  DQMenuConfiguracao.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 25/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//
#import "DQConfigMenu.h"
#import "DQMenu.h"
#import "DQProtocolMenu.h"

@interface DQMenuConfiguracao : SKSpriteNode<DQProtocolMenu>

@property SKLabelNode *titulo;
@property NSArray *opcoesMenu;


-(id)initMenu;
-(void)configuraTitulo;
-(void)configuraOpcoesMenuQuest;
@end
