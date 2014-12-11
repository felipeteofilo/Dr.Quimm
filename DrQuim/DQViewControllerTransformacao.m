//
//  DQViewControllerTransformacao.m
//  DrQuim
//
//  Created by Felipe Teofilo on 11/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQViewControllerTransformacao.h"


@interface DQViewControllerTransformacao ()

@end

@implementation DQViewControllerTransformacao



-(id)initWithReceita:(NSString*)receita{
    if (self = [super init]) {
        self.receita = receita;
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    SKView * skView = [[SKView alloc]initWithFrame:self.view.bounds];
    DQTelaTransformacao *trans = [[DQTelaTransformacao alloc]initWithSize:skView.bounds.size receita:[DQCoreDataController procurarReceita:@"Líquido Amarelo"]];
    
    [self.view addSubview:skView];
    
    [skView presentScene:trans];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
