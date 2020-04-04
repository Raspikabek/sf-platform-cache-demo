# Platform Cache Demo

This sample demo shows you how Platform Cache works & increasing the performance of your code in some crucial scenarios.

The code contains an Apex Class (`PlatformCacheDemoController`) that contains a method with a SOQL of all Accounts + Child contacts + goes through every contact to see how many contacts has each account.

Definitely this is not the best way to count how many contacts we have, however is a great example of a large operation that can be cached with Platform Cache and retrieve the data from the cache instead of process every time the same method.

Remember that with Platform Cache we can store any structure of data we need. Best practices is not only to replace specific heavy SOQL but to replace heavy loads of data processing as well.

We recommend to create a new Scratch Org, set it as default + create the mock data that exists in this repository (1k Accounts + 2k Contacts);

## How to Install:

### Fully automated process

This process performs the following actions:

1. Creates a new Scratch Org and sets the new org as default
2. Push the code to the new Scratch Org
3. Sets the necessary permission set automatically
4. Uploads the mock data necessary for testing

```
npm run sfdx:setup:project
```

### New brand Scratch Org

Create a new Scratch Org:

```
sfdx force:org:create -v YOUR_DEVHUB_ALIAS -a sf-platform-cache-demo -s -f config/project-scratch-def.json
```

Push the package to the new Scratch Org:

```
sfdx force:org:push
```

### Your own Sandbox or Developer Edition org

Deploy the code into your target org with Source commands:

```
sfdx force:source:deploy -p sf-platform-cache-demo
```

## Give you access to the Sample App

Assign to yourself the Permission Set: `sf-platform-cache-demo`

```
sfdx force:user:permset:assign -n sf_platform_cache_demo
```

or

```
npm run sfdx:permset:assign
```

## Create some sample data in your org

_(this commands creates 1k accounts + 2 contacts per account in bulk in your default org)_

```
sfdx force:data:bulk:upsert -s Account -f ./assets/mock_accounts.csv -i External_Id__c
sfdx force:data:bulk:upsert -s Contact -f ./assets/mock_contacts.csv -i Id
```

or

```
npm run sfdx:create:data
```

## How the App Works?

-   Make sure you have completed all previous steps (new scratch org + permset + mock data upload)
-   Open your Scratch Org & navigate to Platform Cache Demo application & play around with the buttons

```
sfdx force:org:open -p /lightning/n/Platform_Cache_Demo
```

or

```
npm run sfdx:open:demoapp
```
