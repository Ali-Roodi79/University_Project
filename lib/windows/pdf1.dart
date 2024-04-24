import 'package:flutter/material.dart';
import 'dart:math' as math;
class pdfone extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return pdfonestate();
  }

}
class pdfonestate extends State<pdfone>{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/windows/pdf.png"),fit: BoxFit.fitHeight
            )
        ),
        child: Stack(
          children: [
            Padding(padding: EdgeInsets.only(top: size.height*0.3),child: Transform.rotate(angle: math.pi/2,child: SingleChildScrollView(
              child: SizedBox(
                height: size.height*0.35,
                width: size.width*0.85,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Directionality(child: Text("همواره با استفاده از روش‌های خاص خود، به صورت گرافیتی بالای سر قربانیانشان نوشته‌هایی مرموز و ترسناک را به جا می‌گذاشتند.سایه‌های قاتل، با اعضایی حرفه‌ای و بی‌رحم، در تاریک‌ترین کناره‌های شهر جاسوسی و قدرت خود را به نمایش می‌گذاشتند. هیچکس نمی‌توانست به این باند دست پیدا کند و همچنین همه تلاش‌ها برای شکست دادن آنها ناموفق می‌ماند.با گذشت زمان، آدمکش سایه توانست با تحقیقات و پیگیری‌های خود، اعضای باند را شناسایی کند. او با استفاده از تکنیک‌های خاص خود، هر بار که یک عضو از سایه‌های قاتل را به قتل می‌رساند، بالای سر قربانی نوشته‌های مرموزی را به جا می‌گذارد. این نوشته‌ها حاوی اطلاعاتی درباره خود آدمکش سایه و همچنین تهدیدات ترسناکی برای باقی اعضای باند بود.با گذشت زمان، سایه‌های قاتل دچار وحشت شدند. آنها متوجه شدند که آدمکش سایه به دنبال نابودی کامل باندشان است و هیچ‌کس نمی‌تواند از او در امان باشد. اعضای باند، در ترس و وحشت، هر روز به صورت مرموز و پنهان از آدمکش سایه می‌ترسیدند.نبرد بین آدمکش سایه و سایه‌های قاتل به طور پیوسته ادامه داشت. هر طرف با استفاده از تکنیک‌ها و استعداد خود، سعی در نابودی دیگری داشت. اما هیچ‌کدام از آنها نمی‌توانست به پیروزی نهایی دست پیدا کند.",
                      style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 25),),textDirection: TextDirection.rtl,),
                  ),
                ),
              ),
            ),),),
            Positioned(right: size.width*0.92,child: SizedBox(
              height: size.height,
              width: size.width*0.08,
              child: Container(
                height: size.height,
                width: size.width*0.08,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/windows/desktop/na.png"),fit: BoxFit.fitHeight)),
              ),
            )),
          ],
        ),
      ),
    );
  }

}