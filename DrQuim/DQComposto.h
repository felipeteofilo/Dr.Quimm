//
//  DQComposto.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Composto.h"

@interface DQComposto : UIButton


@property NSString* nome;
@property NSString *imagem;
@property NSArray *arrayElementos;

-(id)initComEntidadeComposto :(Composto*)composto;



@end
