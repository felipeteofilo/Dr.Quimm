//
//  Receita.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 06/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "Receita.h"


@implementation Receita

@dynamic descricao;
@dynamic id_item_gerar;
@dynamic info_conf_composto;
@dynamic nome;
@dynamic composto_receita;

@end

@implementation arrayInfoConfigComposto

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