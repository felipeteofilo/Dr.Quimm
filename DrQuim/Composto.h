//
//  Composto.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 18/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Composto : NSManagedObject

@property (nonatomic, retain) NSString * formula_molecular;
@property (nonatomic, retain) NSString * imagem;
@property (nonatomic, retain) id info_Composto;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) id elementos;

@end
