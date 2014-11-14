//
//  SMRotaryWheel.h
//  RotaryWheelProject
//
//  Created by cesarerocchi on 2/10/12.
//  Copyright (c) 2012 studiomagnolia.com. All rights reserved.


#import <UIKit/UIKit.h>
#import "DQcirculoGiratorioProtocolo.h"
#import "DQAreaComposto.h"

@interface DQcirculoControle : UIControl

@property (weak) id <DQcirculoGiratorioProtocolo> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfSections;
@property CGAffineTransform startTransform;
@property (nonatomic, strong) NSMutableArray *cloves;
@property int currentValue;

@property NSArray *arrayDeCompostos;
@property int tagImagemSelecionada;


- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber eCompostos:(NSArray *)arrayDeCompostos;


@end
