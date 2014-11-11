//
//  DQReceita.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receita.h"

@interface DQReceita : UIButton

@property NSString *nome;
@property NSString *descricao;
@property NSMutableArray *arrayCompostos;

-(id)initComReceita:(Receita*)receita;

//-(void)iniciarCompostos;

@end
