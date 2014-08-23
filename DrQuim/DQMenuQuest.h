//
//  DQMenuQuest.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 28/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//
#import "DQProtocolMenu.h"
#import "DQOpcaoMenu.h"
#import "DQConfigMenu.h"
#import "DQReferenciaMissaoJogador.h"
#import "DQTexto.h"
#import "DQJogador.h"

@interface DQMenuQuest : SKSpriteNode <DQProtocolMenu>

@property SKLabelNode *titulo;
@property NSArray *opcoesMenu;
@property SKSpriteNode *detalheQuest;

@property SKSpriteNode *opcaoAnterior;
@property SKSpriteNode *proximaOpcao;

-(id)initMenu;
-(void)configuraTitulo;
-(void)configuraOpcoesMenuQuest;
@end
