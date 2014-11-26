//
//  DQTelaInfoReceitas.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 25/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"
#import "DQCoreDataController.h"
#import "DQScrollView.h"

@interface DQTelaInfoReceitas : UIScrollView

@property UIView *viewInfo;
@property NSString* ultimaReceita;
@property DQScrollView *scrollViewCompostos;


-(id)initComReceitas:(NSArray*)receitas frame:(CGRect)frame;


@end
