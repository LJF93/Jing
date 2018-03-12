
#import "MPProtocolOptionalViewController.h"
#import "MPUseProtocolOptional.h"
#import "MPOraceDataBase.h"
#import "MPMSSqlDataBase.h"

@interface MPProtocolOptionalViewController ()

@end

@implementation MPProtocolOptionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    MPUseProtocolOptional *protocolOptional=[[MPUseProtocolOptional alloc]init];
    
    [protocolOptional connetcomWithConnetionProtocol:[MPOraceDataBase new]withIndentifier:@"Oracle"];
    
    [protocolOptional connetcomWithConnetionProtocol:[MPMSSqlDataBase new] withIndentifier:@"MSSql"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
