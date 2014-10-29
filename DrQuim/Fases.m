//
//  Fases.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 28/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "Fases.h"


@implementation Fases

@dynamic disponivel;
@dynamic id;
@dynamic requisitos;

@end

@implementation ArrayRequisitos

+(Class)transformedValueClass{
    return [NSArray class];
}

+(BOOL)allowsReverseTransformation{
    return YES;
}

-(id)transformedValue:(id)value{
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}

-(id)reverseTransformedValue:(id)value{
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];
}
@end