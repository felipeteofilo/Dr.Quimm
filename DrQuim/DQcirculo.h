//
//  UIControl+DQcirculo.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 17/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQProtocoloGiratorio.h"
#import "DQAreaComposto.h"

@interface DQcirculo: UIControl

@property NSArray *arrayDeCompostos;
@property int tagImagemSelecionada;
@property int compostoAtual;
@property int numeroDeCompostos;
@property id <DQProtocoloGiratorio> delegate;

@property UIView *base;

-(id)initComFrame: (CGRect)frame comDelegate:(id)del comNumeroDeCompostos:(int)numeroDeCompostos eCompostos:(NSArray *)arrayDeCompostos;


@end
