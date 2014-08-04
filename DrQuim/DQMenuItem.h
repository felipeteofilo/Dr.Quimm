//
//  DQMenuItem.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 23/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQProtocolMenu.h"
#import "DQItensJogador.h"
#import "DQItem.h"
#import "DQConfigMenu.h"
#import "DQTexto.h"

@interface DQMenuItem : SKSpriteNode<DQProtocolMenu>


@property DQItensJogador *itensJogador;

@property SKLabelNode *titulo;
@property NSArray *itens;

@property int itensLinha;
@property int itensColuna;

@end
