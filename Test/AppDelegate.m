//
//  AppDelegate.m
//  Test
//
//  Created by Nguyen Tran on 5/20/16.
//  Copyright © 2016 MyTrax. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
}

@end

@implementation AppDelegate

-(int) solution:(NSString*)E b:(NSString *)L {
    int entrance=2;
    int FIRST_HRS=3;
    int NEXT_HRS=4;
    int enterHour = [[[E componentsSeparatedByString:@":"] firstObject] intValue];
    int enterMin = [[[E componentsSeparatedByString:@":"] lastObject] intValue];
    int exitHour = [[[L componentsSeparatedByString:@":"] firstObject] intValue];
    int exitMin = [[[L componentsSeparatedByString:@":"] lastObject] intValue];
    int enterTime= enterHour*60+enterMin;
    int exitTime= exitHour*60+exitMin;
    int parkTime = exitTime-enterTime;
    int parkHour=parkTime/60;
    if(parkTime%60!=0)
    {
        parkHour++;
    }
    int fee = entrance+FIRST_HRS+(parkHour-1)*NEXT_HRS;
    return fee;
}
-(int) solution2:(NSMutableArray*) A {
    int length = [A count];
    int total=0;
    int nextDay=-1;
    for(int i=0;i<length;i++)
    {
        if(nextDay==length)break;
        if(nextDay>0)
        {
            i=nextDay;
        }
        nextDay=i+7;
        int paid=0;
        int firstDayInArr=[A[i] intValue];
        for(int j=i;j<i+7;j++)//check next 7 days
        {
            if(j>=length)
            {
                nextDay=length;
                break;
            }
            if([A[j]intValue] < firstDayInArr+7)
            {
                paid+=2;
            }
            else
            {
                nextDay=j;
                break;
            }
        }
        if(paid>7)
        {
            //we should buy 7 days ticket;
            total+=7;
        }
        else
        {
            //we should buy 1 day ticket for this day;
            total+=paid;
        }
    }
    if(total>25)
    {
        //we should buy 30 days ticket
        NSLog(@"max roi total=%d",total);
        total=25;
    }
    return total;
}
-(NSMutableArray *) solution3:(NSMutableArray *)T {
    // write your code in Objective-C 2.0
    NSMutableArray*arr=[NSMutableArray arrayWithCapacity:0];
    int capital=-1;
    int length = [T count];
    NSInteger numCities[length];
    NSInteger distanceCities[length];
    for(int i=0;i<length;i++)
    {
        numCities[i]=0;
        distanceCities[i]=-1;
        if(i==[T[i] intValue])
        {
            capital=i;
//            break;
        }
    }
    
    for(int i=0;i<length;i++)
    {
        if(i==capital) continue;
        if([T[i] intValue]==capital)
        {
            distanceCities[i]=1;
            int tmp=numCities[distanceCities[i]-1]+1;
            numCities[distanceCities[i]-1]=tmp;
        }
        
    }
    int total=0;
    int currentDistance=0;
    for(int i=0;i<length;i++)
    {
        if(total>=length)break;
        if(i==capital) continue;
        if(distanceCities[i]==1)continue;
        int count=0;
        for(int j=i;j<length;j++)
        {
            if([T[i] intValue]==j)
            {
                if(distanceCities[j]<0)
                {
                    distanceCities[j]=currentDistance;
                }
                int tmp=distanceCities[j]+1;
                distanceCities[i]=tmp;
                currentDistance=tmp;
                count=numCities[distanceCities[i]-1]+1;
                numCities[distanceCities[i]-1]=count;
            }
        }
        total+=count;
    }
    for(int i=0;i<length-1;i++)
    {
        [arr addObject:[NSString stringWithFormat:@"%d",numCities[i]]];
    }
    return arr;
}
-(void) dijkstra:(int) source//diem bat dau
{
    int n=10;
    int dest=8;
    int input[10]= {1,1,9,9,9,3,3,3,6,1};
    long aMTK[10][10];//do thi
    int truoc[10];//luu cac dinh truoc tai thoi diem dang xet cua dinh
    bool mark[10];//de danh dau dinh dang xet
    long dodai[10];//luu do dai  duong di tu dinh bat dau den cac dinh con lai
    int count;//de dich cac dinh
    for(int i=0;i<10;i++)
    {
        for(int j=0;j<10;j++)
        {
            aMTK[i][j]=INT_MAX;
        }
    }
    for(int i=0;i<10;i++ )
    {
        int j= input[i];
        aMTK[i][j]=1;
        aMTK[j][i]=1;
        dodai[i]=INT_MAX;
        mark[i]=false;
    }
    dodai[source]=0;
    truoc[source]=0;
    mark[source]=true;
    
    
    int i,j,u=source;
    count=0;
    while(!mark[dest])//lan luot xet cac dinh
    {
        //tim dinh co duong di ngan nhat tu dinh dang xet
        int min=1000;
        for(i=0;i<n;i++)
        {
            if(!mark[i])//neu chua xet dinh i;
            {
                if(min>=dodai[i])//neu dodai[i] nho hon min
                {
                    min=dodai[i];//min bang do dai cua dodai[i]
                    u=i;//t bang dinh i
                }
            }
        }
        //bat dau lay u ra xet
        mark[u]=true;//danh dau da xet;
        
        if(!mark[dest])
        {
            for(i=0;i<n;i++)
            {
//                NSLog(@"%ld,%ld,%ld",dodai[u],aMTK[i][u],dodai[i]);
                if(!mark[i]&&dodai[u]+aMTK[i][u]<dodai[i] &&aMTK[i][u]<INT_MAX)
                {
                    dodai[i]=dodai[u]+aMTK[i][u];
                    truoc[i]=u;
                    NSLog(@"do dai tu %d den %d=%ld",source,i,dodai[i]);
                }
            }
        }
        
    }
    NSLog(@"do dai tu %d den %d=%ld",source,dest,dodai[dest]);
}
-(NSMutableArray *) solution4:(NSMutableArray *)T {
    NSMutableArray*arr=[NSMutableArray arrayWithCapacity:0];
    int source =1;
    [self dijkstra:source];
    return arr;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSString* a = @"10:00";
//    NSString* b = @"13:21";
//    NSString* a = @"09:21";
//    NSString* b = @"11:22";
//    int solution = [self solution:a b:b];
//    NSLog(@"solution=%d",solution);

//    NSArray*a =@[@"1",@"2",@"4",@"5",@"7",@"29",@"30"];
    NSArray*a =@[@"1",@"2",@"3",@"4",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"17",@"19",@"20",@"21",@"29"];
    int solution=[self solution2:a];
    NSLog(@"solution2=%d",solution);
    
    //1,3,2,3
//    NSMutableString*str=[[NSMutableString alloc]init];
//    for(int i=0;i<[a count];i++)
//    {
//        [str appendFormat:@"%d,",[a[i] intValue]];
//    }
//    NSLog(@"str=%@",str);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
