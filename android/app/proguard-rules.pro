-keep class **.zego.** { *; }
-keep class **.zego.zim.**  { *; }
-keep class **.**.zego_zim.** { *; }
#In app Purchase
-keep class com.amazon.** {*;}
-keep class com.dooboolab.** { *; }
-keep class com.android.vending.billing.**
-dontwarn com.amazon.**
-keepattributes *Annotation*