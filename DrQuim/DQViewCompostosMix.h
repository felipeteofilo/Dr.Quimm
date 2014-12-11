//
//  DQViewCompostosMix.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 04/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "DQCoreDataController.h"
#import "DQTelaInfoReceitas.h"
#import "DQTelaTransformacao.h"
#import "DQViewControllerTransformacao.h"

@interface DQViewCompostosMix : UIScrollView 




@property Receita *receita;
@property NSMutableArray * compostosParaMix;
@property UIButton *botaoMix;


-(id)initComTamanho:(CGRect)frame;
-(void)mostrarBotaoMix;
-(void)adicionarComposto :(NSString*)nome;

@end
