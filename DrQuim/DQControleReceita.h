//
//  DQControleReceita.h
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 30/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQControleReceita : NSObject

+(NSArray*)receitasConfiguradas;
+(NSDictionary*)detalheReceita:(int)nReceita;

@end
