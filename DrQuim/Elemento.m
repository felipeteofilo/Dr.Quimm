//
//  Elemento.m
//  DrQuim
//

//  Created by FELIPE TEOFILO SOUZA SANTOS on 06/11/14.

//  Created by Leonardo de Sousa Mendes on 06/11/14.

//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "Elemento.h"



@implementation Elemento

@dynamic imagem;
@dynamic info_elemento;
@dynamic n_eletrons;
@dynamic nome;
@dynamic simbolo;

@end

@implementation dictionaryInformacoes

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

