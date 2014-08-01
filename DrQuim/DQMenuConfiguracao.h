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
#import "DQControleUserDefalts.h"
#import "DQBarraStatus.h"

@interface DQMenuConfiguracao : SKSpriteNode<DQProtocolMenu>

@property SKLabelNode *titulo;
@property NSArray *opcoesMenu;

@property SKSpriteNode *estadoSom;
@property SKSpriteNode *estadoMusica;

@property DQBarraStatus *volumeSom;
@property DQBarraStatus *volumeMusica;

@property SKSpriteNode *botaoMudoMusica;
@property SKSpriteNode *botaoMudoSons;

@property SKSpriteNode *fundoVolumeMusica;
@property SKSpriteNode *fundoVolumeSons;

-(id)initMenu;
-(void)configuraTitulo;
@end
