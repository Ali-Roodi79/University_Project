import 'package:flutter/material.dart';
import 'package:nullbox/Home4Level3.dart';
Map<String,List> subtitle={
  "CH02CH01":[0,7,"می خواهم با استفان صحبت بکنم",4,0,"او از بیماران سابق من بوده و او را میشناختم",8,3,"با توجه به علائم مشخص است مقتول مسموم شده",12,5," "],
  "CH02CH19":[0,7,"می خواهم با استفان حرف بزنم",4,0,"رنگش پریده به نظر میرسد مشکل یا بیماری خاصی دارد",7,5," "],
  "CH03CH12":[0,7,"می خواهم با جیسون حرف بزنم",3,7,"او یک آدم بی سر و پا است. هر چه تلاش کردم با من مصاحبه نکرد. مطمئنم کاسه ای زیر نیم کاسه دارد",17,5," "],
  "CH03CH30":[0,7,"می خواهم با جیسون حرف بزنم",4,0,"آدم خطرناکی است و با خود انواع آلت قتاله را حمل میکند",7,5," "],
  "CH12CH02":[0,7,"می خواهم با نانسی حرف بزنم",3,9,"حالا که اینجا گیر افتادیم به او میگویم من را هم معاینه کند که با حال ناخوش به صحنه فیلمبرداری نروم",7,5," "],
  "CH12CH03":[0,7,"می خواهم با نانسی حرف بزنم",3,8,"دم مزاحم و اعصاب خوردکنی است",7,0,"به نظرم یک قاتل حرفه ای باشد زیرا آنقدر روی مغزت رژه میرود تا جانت به لبت برسد",12,5," "],
  "CH12CH23":[0,7,"می خواهم با نانسی حرف بزنم",2,0,"برای عکس گرفتن با من لحظه شماری میکرد",4,8,"ولی حوصله اش را نداشتم",6,0,"کاراگاه گوشی هایمان را هم که گرفته  پس از عکس خبری نیست ",14,0," "],
  "CH14CH02":[0,7,"می خواهم با گای حرف بزنم",4,0,"ایشان دکتر بسیار توانمندی است از هم سفر شدن با ایشان خیلی خوشحال هستم",7,5," "],
  "CH14CH18":[0,7,"می خواهم با گای حرف بزنم",3,9,"او معلم فیزیک است و بسیار متشخص به نظر میرسد",7,5," "],
  "CH14CH23":[0,7,"می خواهم با گای حرف بزنم",3,5,"در تمام مسیر هم صحبت بودیم",6,3,"برای ادامه تحصیل به خارج از کشور می‌رود",7,5," "],
  "CH19CH14":[0,7,"می خواهم با تونی حرف بزنم",3,9,"دستیار پزشک بهتر از همه سم ها را می‌شناسد و بلد است از آنها استفاده کند",7,5,""],
  "CH19CH21":[0,7,"می خواهم با تونی حرف بزنم",4,0,"آدم دغل بازی است و سعی داشت جنس های بنجلش را به من قالب کند",7,5,""],
  "CH21CH02":[0,7,"می خواهم با اریک حرف بزنم",4,2,"دیدم که قبل از پرواز و در فرودگاه داشت با قربانی گفت و گو میکرد",7,5,""],
  "CH21CH03":[0,7,"می خواهم با اریک حرف بزنم",4,3,"او در نزدیکی جای قتل بوده و چندین بار با مقتول گفتگو داشته و از او سوالاتی پرسیده",7,5,""],
  "CH21CH19":[0,7,"می خواهم با اریک حرف بزنم",4,3,"آدم ساده ای به نظر میرسید اما نتوانستم او را متقاعد کنم جنس هایم را بخرد",8,7,"گول ظاهرش را نخورید بسیار آب زیر کاه است",13,5,""],
  "CH21CH30":[0,7,"می خواهم با اریک حرف بزنم",4,3,"از ابتدای ماجرای قتل شروع به جمع کردن گوشی ها کرد و طوری صحنه را به دست گرفت که هیچکس به او شک نکند",10,0,"از کجا معلوم کار خودش نباشد؟",15,0,""],
  "CH23CH12":[0,7,"می خواهم با برندن حرف بزنم",4,3,"بازیگر با پارتی بازی به بهانه‌ی محافظت از خودش حمل اسلحه به هواپیما داشته",8,5,"او یک قانون شکن و معروف به فساد است",14,0,""],
  "CH23CH18":[0,7,"می خواهم با برندن حرف بزنم",4,5,"انسان بسیار شریفی است و به دیگران کمک میکند",7,5,""],
  "CH30CH03":[0,7,"می خواهم با دیویس صحبت کنم",4,3,"او در نزدیکی جای قتل بوده و چندین بار با مقتول گفتگو داشته و از او سوالات آزاردهنده پرسیده و مقتول را عصبی کرده",7,5,""],
  "CH30CH19":[0,7,"می خواهم با دیویس حرف بزنم",4,3,"سرباز باید در پست خود باشد و نمی‌تواند در مدت خدمت کشور را ترک کند",8,5,"نمیدانم چگونه در این پرواز حضور دارد",14,0,""],
  "CH03CH21":[0,7,"می خواهم با جیسون حرف بزنم",3,3,"خیلی ادم مشکوکی هست مخفیانه با همه صحبت می کرد و سعی داشت تفرقه افکنی بکند.",8,7,""],
  "CH03CH14":[0,5,"می خواهم با جیسون حرف بزنم",3,4,"دستیار پزشک هم مانند خود پزشک کارش نجات دادن ادم هاست.",8,2,""],
  "CH12CH14":[0,5,"می خواهم با نانسی حرف بزنم",4,0,"من برای سردردم دارو می خواستم و او کمکم کرد.",8,0,""],
  "CH12CH21":[0,4,"می خواهم با نانسی حرف بزنم",3,3,"بنظر می رسد در کیف بزرگی که همراه خود دارد چیز های خطرناکی پنهان کرده است. ",6,5,"او یک شیاد است.",9,3,""],
  "CH14CH12":[0,5,"می خواهم با گای حرف بزنم",3,2,"گویا مشکل سر درد داشت و از من تعدادی قرص مسکن می خواست.",8,4,""],
  "CH14CH21":[0,5,"می خواهم با گای حرف بزنم",2,9,"درباره علامت ها و مسمویت مقتول از من سوال های زیادی می پرسید",6,2,"بنظر خیلی کنجکاو است",9,5,""],
  "CH21CH12":[0,3,"می خواهم با اریک حرف بزنم",2,9,"او یک بازیگر بی استعداد است که فیلم هایش هیچ فروشی نمی کنند و برای گذراندن زندگی دست به هرکاری می زند.",8,5,""],
  "CH21CH14":[0,4,"می خواهم با اریک حرف بزنم",3,2,"من دیدم که همراهش دارو ها و شیشه های رنگی خاصی داشت شاید یکی از آن ها سم باشد.",8,5,""],
  "CH30CL03":[0,9,"من همه گوشی ها را بررسی کردم ",2,9,"پیامک های مشکوک تهدید به قتل برای همه ارسال شده است ",6,0,"اما کارکتر های CH21  و CH12 گوشی های خود را تحویل نداده اند.",13,0,""],
  "Message2":[],
  "Message2-2":[],
  "Message3":[],
  "Message4":[],
  "Message5":[],


};

search(String name){
  List? mylist=subtitle[name];
  print(mylist);
  sub(mylist!);
}