#include "iCopyInSocialController.h"
#include <spawn.h>

#define PreferencesChangedNotification "com.crazymind90.icopyinsocial"
@implementation iCopyInSocialController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}



-(void) ApplyChanges {

	[self.navigationController popToRootViewControllerAnimated:YES];

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [NSThread sleepForTimeInterval:0.40];

        dispatch_async(dispatch_get_main_queue(), ^{

					pid_t pid;
			    const char* args[] = {"killall", "backboardd", NULL};
			    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);

        });

    });

}



- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {


    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {

        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;

        tableViewHeaderFooterView.textLabel.text = [tableViewHeaderFooterView.textLabel.text capitalizedString];
        tableViewHeaderFooterView.textLabel.font = [UIFont systemFontOfSize:16];

    }
}



-(void) CrazyMind {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/CrazyMind90"] options:@{} completionHandler:nil];

}



@end
