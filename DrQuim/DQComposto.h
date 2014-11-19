//
//  DQComposto.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Composto.h"
#import "DQTelaInfoComposto.h"

@interface DQComposto : UIImageView


@property NSString* nome;
@property NSString *imagem;
@property NSMutableArray *arrayElementos;
@property DQTelaInfoComposto *info;

-(id)initComEntidadeComposto :(Composto*)composto :(CGRect)frame;
-(void)mostrarInfoComposto :(UIView*)view;



@end
