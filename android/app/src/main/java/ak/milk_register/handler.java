package ak.milk_register;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class handler {
    public Context c;
    public String s;

    public handler(Context x) {
        this.c = x;

    }

    public void set() {


            Intent  i = new Intent(c, service.class);
            PendingIntent p = PendingIntent.getBroadcast(c, 2, i, 0);
            AlarmManager am = (AlarmManager) c.getSystemService(Context.ALARM_SERVICE);
            Log.d("tg44", "in set");
            if(am!=null)

            {

                am.setRepeating(AlarmManager.RTC_WAKEUP, System.currentTimeMillis() + 1000,
                        5* 60 * 1000, p);

            }


        Log.d("tg9", "in set");


    }

    public void cancel()
    {

               Intent i = new Intent(c, service.class);
            PendingIntent p=PendingIntent.getBroadcast(c,2,i,0);
            AlarmManager am=(AlarmManager)c.getSystemService(Context.ALARM_SERVICE);
            am.cancel(p);



        }
    }


