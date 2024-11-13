```java
package com.project.redistest.schedule;  
  
import java.util.concurrent.TimeUnit;  
import org.springframework.scheduling.Trigger;  
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;  
import org.springframework.scheduling.support.CronTrigger;  
import org.springframework.scheduling.support.PeriodicTrigger;  
import org.springframework.stereotype.Component;  
  
@Component  
public class DynamicScheduler {  
  
    private ThreadPoolTaskScheduler scheduler;  
    private String cron = "*/1 * * * * *";  
    private int ms = 3000;  
  
    public void startScheduler() {  
        scheduler = new ThreadPoolTaskScheduler();  
        scheduler.setPoolSize(5);  
        scheduler.initialize();  
        scheduler.schedule(getRunnable(), getCronTrigger());  
    }  
  
    public void stopScheduler() {  
        scheduler.shutdown();  
    }  
  
    public Runnable getRunnable() {  
        return () -> {  
            System.out.println("DynamicScheduler.runnable");  
        };  
    }  
  
    private Trigger getCronTrigger() {  
        return new CronTrigger(cron);  
    }  
  
    public void updateCronSet(String cron) {  
        this.cron = cron;  
    }  
  
    private Trigger getPeriodcTrigger() {  
        return new PeriodicTrigger(ms, TimeUnit.MILLISECONDS);  
    }  
  
    public void updateMillisecondSet(int ms) {  
        this.ms = ms;  
    }  
}
```