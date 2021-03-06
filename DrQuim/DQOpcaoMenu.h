//
//  DQOpcaoMenu.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 25/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQMenuItem.h"
#import "DQMenuConfiguracao.h"
#import "DQConfigMenu.h"
#import "DQMenuQuest.h"
#import "DQMenuReceita.h"
#import "DQMenuArmadilhas.h"

@interface DQOpcaoMenu : SKSpriteNode <DQProtocolMenu>

@property SKNode *conteudo;
@property NSString *titulo;

-(id)initOpcaoTitulo:(NSString*)titulo;
-(void)configuraConteudoQuest:(NSMutableDictionary*)missao index:(int)index;
-(void)configuraConteudoReceita:(NSDictionary*)receita index:(int)index;
-(void)configuraConteudoMenuIndex:(int)index;
-(void)apresentarConteudo;
-(void)esconderConteudo;
@end
