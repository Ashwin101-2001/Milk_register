package ak.milk_register;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.Icon;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.util.Log;
import android.widget.Toast;

import androidx.core.app.NotificationCompat;

import java.util.Calendar;
import java.util.Date;

public class service extends BroadcastReceiver {
    public static final int REQUEST_COARSE_LOCATION=1;
    @Override
    public void onReceive(Context context, Intent intent) {
        String currentDateTimeString = java.text.DateFormat.getDateTimeInstance().format(new Date());
       // Toast.makeText(context, "rec  " + currentDateTimeString, Toast.LENGTH_LONG).show();
        //Uri notification = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
       // Ringtone r = RingtoneManager.getRingtone(context.getApplicationContext(), notification);
       // r.play();
        Calendar rightNow = Calendar.getInstance();
        int h = rightNow.get(Calendar.HOUR_OF_DAY);
        int m = rightNow.get(Calendar.MINUTE);

        if(((h==20)&&(m>=45&&m<=60))||((h==21)&&(m>=0&&m<=60)))
        {


            Log.d("tag1","ab:ab");
            NotificationCompat.Builder mBuilder =
                    new NotificationCompat.Builder(context, "notify_001");
            Intent ii = new Intent();
            Intent i = context.getPackageManager().getLaunchIntentForPackage("ak.milk_register");
            PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, i, 0);
            PendingIntent p = PendingIntent.getActivity(context, 0, i, 0);
            NotificationCompat.BigTextStyle bigText = new NotificationCompat.BigTextStyle();
            //bigText.bigText("ab");
            //bigText.setBigContentTitle("Today's Bible Verse");
            bigText.setSummaryText("Daily remainder");

            mBuilder.setContentIntent(pendingIntent);
            mBuilder.setSmallIcon(android.R.drawable.sym_def_app_icon);
            mBuilder.setContentTitle(" Click to add milk for today ");
            mBuilder.setTimeoutAfter(600000);
            int nonTransparentRed = Color.argb(255, 255, 0, 0);
            mBuilder.setColor(nonTransparentRed);
            //mBuilder.
            // mBuilder.setContentText("Your text");
            mBuilder.setPriority(Notification.PRIORITY_MAX);
            mBuilder.setStyle(bigText);
            // mBuilder.addAction(android.R.drawable.sym_def_app_icon,"app",p);
            // mBuilder.addInvisibleAction(android.R.drawable.sym_def_app_icon,"app11",p);
            //mBuilder.setOngoing(true);
            NotificationManager mNotificationManager =
                    (NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);
            Log.d("tag6","done");

// === Removed some obsoletes
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
            {
                String channelId = "Your_channel_id";
                NotificationChannel channel = new NotificationChannel(
                        channelId,
                        "Channel human readable title",
                        NotificationManager.IMPORTANCE_HIGH);
                mNotificationManager.createNotificationChannel(channel);
                mBuilder.setChannelId(channelId);
            }
            Log.d("tag5","near notify");
            mNotificationManager.notify(0,mBuilder.build());





        }




    }


};


