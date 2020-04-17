public with sharing class PlatformCacheDemoController {
    @AuraEnabled
    public static Long executeSampleCode(Boolean usePlatformCache) {
        long startTime = System.currentTimeMillis();

        if (usePlatformCache) {
            List<AccountExtraInfo> info = new List<AccountExtraInfo>();
            CacheManager cache = new CacheManager();
            String cacheKey = 'local.SamplePartition.contactsInAccounts';
            Object valueFromCache = cache.get(cacheKey);
            if (valueFromCache == null) {
                info = doSomethingCrazy();
                cache.put(cacheKey, info, 10000);
            } else {
                info = (List<AccountExtraInfo>) valueFromCache;
            }
        } else {
            doSomethingCrazy();
        }
        long elapsedTime = System.currentTimeMillis() - startTime;
        return elapsedTime;
    }

    private static List<AccountExtraInfo> doSomethingCrazy() {
        List<Account> accounts = new List<Account>();
        accounts = [
            SELECT Id, Name, Description, (SELECT Id, Name, Email FROM Contacts)
            FROM Account
        ];
        List<AccountExtraInfo> accountsInfo = new List<AccountExtraInfo>();
        for (Account a : accounts) {
            Integer i = 0;
            for (Contact c : a.Contacts) {
                i = i + 1;
            }
            accountsInfo.add(new AccountExtraInfo(a.Id, i));
        }
        return accountsInfo;
    }

    public class AccountExtraInfo {
        public Id accountId;
        public Integer numberOfContacts;

        public AccountExtraInfo(Id id, Integer value) {
            accountId = id;
            numberOfContacts = value;
        }
    }

    @AuraEnabled
    public static Long badPracticeSample() {
        long startTime = System.currentTimeMillis();
        List<AccountExtraInfo> info = new List<AccountExtraInfo>();
        info = doSomethingCrazy();
        CacheManager cache = new CacheManager();
        for (AccountExtraInfo a : info) {
            String cacheKey = 'local.SamplePartition.acc' + a.accountId;
            cache.put(cacheKey, a, 10000);
        }
        long elapsedTime = System.currentTimeMillis() - startTime;
        return elapsedTime;
    }
}
