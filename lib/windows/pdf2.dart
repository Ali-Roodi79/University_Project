import 'package:flutter/material.dart';
import 'dart:math' as math;
class pdftwo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return pdftwostate();
  }

}
class pdftwostate extends State<pdftwo>{
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
                    child: Directionality(child: Text("در شهری پر از فساد و جرم، یک فرد قاچاقچی به نام شبح تاریک با فروش اسلحه‌های غیرقانونی در حال فعالیت بود. او با استفاده از روش‌های خلاف قانون، به صورت مخفیانه و مرموز اسلحه‌های خود را به مشتریان خود می‌فروخت.شبح تاریک با همکارانی حرفه‌ای و بی‌رحم در تمامی کناره‌های شهر، فعالیت خود را ادامه می‌داد. هیچکس نمی‌توانست به این باند دست پیدا کند و تلاش‌های پلیس برای دستگیری آنها ناموفق می‌ماند.روزی، یک کارآگاه حرفه‌ای به نام سایه شکارچی به شهر فرستاده شد. او با استفاده از تحقیقات و پیگیری‌های خود، اعضای باند قاچاقچی را شناسایی کرد. سایه شکارچی با استفاده از تکنیک‌های خاص خود، هر بار که یک عضو از باند را دستگیر می‌کرد، پرونده‌های مربوط به فعالیت‌های غیرقانونی آنها را تشکیل می‌داد و به دستگاه قضایی ارسال می‌کرد.با گذشت زمان، باند قاچاقچی دچار وحشت شد. آنها متوجه شدند که سایه شکارچی به دنبال نابودی کامل باندشان است و هیچ‌کس نمی‌تواند از او در امان باشد. اعضای باند، در ترس و وحشت، هر روز از سایه شکارچی می‌ترسیدند.سایه شکارچی، با هوش و استعداد خود، توانست هر بار یک قاچاقچی را دستگیر کند و پرونده‌های مربوطه را تشکیل دهد. این پرونده‌ها به دستگاه قضایی ارسال می‌شدند و عدالت بر باند قاچاقچی حاکم می‌شد.نبرد بین سایه شکارچی و باند قاچاقچی به طور پیوسته ادامه داشت. هر طرف با استفاده از تکنیک‌ها و استعداد خود، سعی در نابودی دیگری داشت. اما هیچ‌کدام از آنها نمی‌توانست به پیروزی نهایی دست پیدا کند.این داستان همواره با جنگ و نبرد بین سایه شکارچی و باند قاچاقچی ادامه می‌یافت. هر روز پرونده‌های جدیدی برای دستگیری و خلاف اعضای باند تشکیل می‌شد.",
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