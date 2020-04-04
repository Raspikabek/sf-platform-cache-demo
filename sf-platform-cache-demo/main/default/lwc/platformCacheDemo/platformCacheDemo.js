import { LightningElement } from "lwc";
import executeSampleCode from "@salesforce/apex/PlatformCacheDemoController.executeSampleCode";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class PlatformCacheDemo extends LightningElement {
    elapsedTimeWithCache = 0;
    elapsedTimeWithoutCache = 0;

    handleClickButton = (event) => {
        let useCache = event.target.name === "cache";
        executeSampleCode({ usePlatformCache: useCache })
            .then((result) => {
                this.setElapsedTime(useCache, result);
            })
            .catch((error) => {
                this.showNotification("Something went wrong!", error, "error");
            });
    };

    setElapsedTime = (hasUsedCache, elapsedTime) => {
        if (hasUsedCache) {
            this.elapsedTimeWithCache = elapsedTime;
        } else {
            this.elapsedTimeWithoutCache = elapsedTime;
        }
    };

    showNotification = (t, m, v) => {
        const evt = new ShowToastEvent({
            title: t,
            message: m,
            variant: v
        });
        this.dispatchEvent(evt);
    };
}
