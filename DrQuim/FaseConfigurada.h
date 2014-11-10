//
//  FaseConfigurada.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 29/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FaseConfigurada : NSManagedObject

@property (nonatomic, retain) NSNumber * disponivel;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) id requisitos;

@end

@interface ArrayRequisitos : NSValueTransformer

@end