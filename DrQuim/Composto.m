//
//  Composto.m
//  DrQuim
////  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.

//  Created by Leonardo de Sousa Mendes on 06/11/14.

//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "Composto.h"

@implementation Composto

@dynamic formula_molecular;
@dynamic imagem;
@dynamic info_Composto;
@dynamic nome;
@dynamic elementos_composto;

@end

@implementation dictionaryInfo

+(Class)transformedValueClass{
    return [NSDictionary class];
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

