//
//  DQMenuReceita.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 30/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQProtocolMenu.h"
#import "DQTexto.h"
#import "DQOpcaoMenu.h"
#import "DQConfigMenu.h"
#import "DQControleReceita.h"


@interface DQMenuReceita : SKSpriteNode<DQProtocolMenu>

@property SKLabelNode *titulo;
@property NSArray *opcoesMenu;
@property SKSpriteNode *detalheReceita;

//Guarda qual o index para fazer a navegacao
@property int indexSelecionado;

-(id)initMenu;
@end
