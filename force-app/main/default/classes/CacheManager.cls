public with sharing class CacheManager {
    @TestVisible
    private Boolean cacheEnabled;

    public CacheManager() {
        cacheEnabled = true;
    }

    public Boolean toogleEnabled() {
        cacheEnabled = !cacheEnabled;
        return cacheEnabled;
    }

    public Boolean isEnabled() {
        return cacheEnabled;
    }

    public Boolean isNotEnabled() {
        return !isEnabled();
    }

    public Object get(String key) {
        if (isNotEnabled()) {
            return null;
        }
        Object value = Cache.Org.get(key);
        return value;
    }

    public void put(String key, Object value, Integer ttl) {
        if (isNotEnabled()) {
            return;
        }
        Cache.Org.put(key, value, ttl);
    }

    public Boolean remove(String key) {
        if (isNotEnabled()) {
            return false;
        }
        Boolean removed = Cache.Org.remove(key);
        return removed;
    }

    public void clearPartition(String partitionName) {
        if (isNotEnabled()) {
            return;
        }

        Cache.OrgPartition orgPart = Cache.Org.getPartition(partitionName);
        for (String key : orgPart.getKeys()) {
            orgPart.remove(key);
        }
    }
}
