//
//  DQProtocolMenu.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 20/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@protocol DQProtocolMenu <NSObject>

@property (nonatomic, readwrite) SEL seletorPausaSkScene;
@property SKLabelNode *titulo;
@property NSArray *opcoesMenu;
@property int nItensLinha;
@property int indexAtual;

-(id)initMenu;
-(void)esconderMenu;

@end
