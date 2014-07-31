//
//  DQMenu.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 19/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQProtocolMenu.h"
#import "DQOpcaoMenu.h"
#import "DQConfigMenu.h"

static NSString *nomeProxMenu=@"Proximo";
static NSString *nomeAntMenu=@"Anterior";

@interface DQMenu : SKSpriteNode <DQProtocolMenu>

@property (nonatomic, readwrite) SEL seletorPausaSkScene;
@property SKLabelNode *titulo;
@property NSArray *opcoesMenu;

@property SKSpriteNode *opcaoAnterior;
@property SKSpriteNode *proximaOpcao;

-(id)initMenuPausaScene:(SEL)pausaScene;
-(void)configuraTitulo;

@end
