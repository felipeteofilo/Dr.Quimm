//
//  DQItem.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 24/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DQItem : SKSpriteNode

@property NSString *nome;
@property NSString *descricao;
@property NSString *categoria;
@property int qndeItem;


-(id)initItemNome:(NSString*)nome descricao:(NSString*)descricao categoria:(NSString*)categoria imagem:(NSString*)imagem Quantidade:(int)quantidade;
@end
