//
//  DQCutsceneView.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 10/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCutsceneView.h"

@implementation DQCutsceneView

-(id)initComParte: (int)parte_
{
    self = [super init];
    if(self)
    {
        self.parte = parte_;
    }
    return self;
}

@end
