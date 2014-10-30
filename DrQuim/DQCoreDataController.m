//
//  DQCoreDataController.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 21/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCoreDataController.h"

@implementation DQCoreDataController

+(Usuario*)procurarJogador :(NSString*)nome{
    DQAppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Usuario"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"(nome = %@)",
     nome];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        return nil;
    }
    else{
        return [objects objectAtIndex:0];
    }
}
+(NSManagedObjectContext*)contextoApp{
    DQAppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    
    return [appDelegate managedObjectContext];
}

+(void)salvarFaseID:(int)idFase comRequisitos:(NSArray*)requisitosFase{
    NSManagedObjectContext *contexto=[DQCoreDataController contextoApp];
    
    FaseConfigurada *novaFase=[[FaseConfigurada alloc]initWithEntity:[NSEntityDescription entityForName:@"FaseConfigurada"  inManagedObjectContext:contexto]insertIntoManagedObjectContext:contexto];
    
    [novaFase setId:[NSNumber numberWithInt:idFase]];
    [novaFase setRequisitos:requisitosFase];
    
    NSError *erro;
    
    [contexto save:&erro];
}
+(NSArray*)pegarTodasFases{
    NSMutableArray* arrayRetorno=[NSMutableArray array];
    
    for (int i=0; i < [DQCoreDataController nFasesCoreData]; i++) {
        [arrayRetorno addObject:[DQCoreDataController procurarFase:i+1]];
    }
    
    return arrayRetorno;
}
+(FaseConfigurada*)procurarFase:(int)idFase{
    NSManagedObjectContext *contexto=[DQCoreDataController contextoApp];
    
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"FaseConfigurada"];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"(id = %i)",idFase]];
    
    NSError *erro;
    NSArray *objects =[contexto executeFetchRequest:request error:&erro];
    
    if ([objects count]==0) {
        return nil;
    }else{
        return [objects objectAtIndex:0];
    }
}

+(int)nFasesCoreData{
    NSManagedObjectContext *contexto=[DQCoreDataController contextoApp];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"FaseConfigurada"];
    [request setPropertiesToFetch:@[@"id"]];
    
    
    NSError *erro;
    NSArray *objetos=[contexto executeFetchRequest:request error:&erro];

    return (int)[objetos count];
}
+(void)salvarVida:(int)vida respeito:(int)respeito fome:(int)fome sede:(int)sede doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setVida:[NSNumber numberWithInt:vida]];
    [newContact setRespeito:[NSNumber numberWithInt:respeito]];
    [newContact setFome:[NSNumber numberWithInt:fome]] ;
    [newContact setSede:[NSNumber numberWithInt:sede]];
    
    
    NSError *erro;
    [context save:&erro];
}
+(void)salvarItens :(NSDictionary*)itens doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
     Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setItens:itens];
    
    
    NSError *erro;
    [context save:&erro];
    
}
+(void)salvarArmadilhas :(NSMutableArray*)armadilhas doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setArmadilhas:armadilhas];
    
    
    NSError *erro;
    [context save:&erro];

}
+(void)salvarMissao:(NSMutableDictionary*)missao doJogador:(NSString*)nome{
    
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setMissao:missao];
    
    
    NSError *erro;
    [context save:&erro];
    
}
+(void)salvarFaseAtual:(int)fase parte:(int)parte doJogador:(NSString*)nome{
    DQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Usuario *newContact = [self procurarJogador:nome];
    
    if (newContact == nil) {
        newContact = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Usuario"
                      inManagedObjectContext:context];
        [newContact setNome:nome];
    }
    
    [newContact setFase:[NSNumber numberWithInt:fase]];
    [newContact setPartefase:[NSNumber numberWithInt:parte]];
    
    
    NSError *erro;
    [context save:&erro];

}
@end
