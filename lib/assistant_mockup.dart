List<String> mockupFindProblem = [
  'คุณเห็นอะไร?',
  'คุณได้ยินอะไร?',
  'คุณได้กลิ่นอะไร?',
  'คุณรู้สึกอะไร?',
  'เกิดอะไรเมื่อคุณติดรถ?'
];
List<String> mockupNameFindProblem = [
  'eye',
  'ear',
  'nose',
  'hand',
  'startEngine'
];

class FindProblem {
  final int id;
  final List<FindProblemDetail> detail;
  const FindProblem({required this.id, required this.detail});
}

class FindProblemDetail {
  final String fect;
  final List<FindProblemWhereAndSolution> whereSolution;
  const FindProblemDetail({required this.fect, required this.whereSolution});
}

class FindProblemWhereAndSolution {
  final String? where;
  final List<String> solution;
  const FindProblemWhereAndSolution({required this.solution, this.where});
}

List<FindProblem> mockupChoiceFindProblem = [
  FindProblem(id: 1, detail: [
    FindProblemDetail(fect: 'ควัน', whereSolution: [
      FindProblemWhereAndSolution(
          where: 'ห้องเครื่อง',
          solution: ['น้ำหล่อเย็นรั่ว >> ล้างและเติมน้ำหล่อเย็น']),
      FindProblemWhereAndSolution(where: 'ไอเสียสีดำ', solution: [
        'เครื่องยนต์เผาผลาญเชื้อเพลิงมากเกินไป >> ตรวจเช็คเครื่องยนต์'
      ]),
    ]),
    FindProblemDetail(fect: 'ยางแบน', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'ยางรั่ว >> ความผันผวนของรอบเดินเบาของรถ, แป้นเบรกแข็ง, และเสียงฟู่ที่ได้ยินภายใต้ท้องรถ',
        'ก้านวาล์วเสียหาย'
      ]),
    ]),
    FindProblemDetail(fect: 'มีไฟแจ้งเตือน', whereSolution: [
      FindProblemWhereAndSolution(where: 'ตรวจดูไฟเครื่องยนต์', solution: [
        'ตรวจดูไฟเครื่องยนต์ >> การวินิจฉัยคำเตือนแดชบอร์ด',
      ]),
      FindProblemWhereAndSolution(where: 'ไฟความดันยัง', solution: [
        'แรงดันลมยางไม่ถูกต้อง >> การวินิจฉัยคำเตือนแดชบอร์ด',
      ]),
      FindProblemWhereAndSolution(where: 'ไฟแจ้งเตือนอุณหภูมิ', solution: [
        'ติดเทอร์โมสตัท >> การวินิจฉัยคำเตือนแดชบอร์ด',
      ]),
      FindProblemWhereAndSolution(
          where: 'ไฟแจ้งเตือนให้เปลี่ยนแบตเตอรี่',
          solution: [
            'เข็มขัดคดเคี้ยวไปมา >> การวินิจฉัยคำเตือนแดชบอร์ด',
          ]),
      FindProblemWhereAndSolution(where: 'ไฟแจ้งเตือนแรงดันน้ำมัน', solution: [
        'ปั้มน้ำมันเสีย >> การวินิจฉัยคำเตือนแดชบอร์ด',
      ]),
      FindProblemWhereAndSolution(where: 'ไฟแจ้งเตือนระบบเบรก', solution: [
        'สวิตช์เบรกจอดรถผิดปกติ >> การวินิจฉัยคำเตือนแดชบอร์ด',
        'การสูญเสียแรงดันเบรก >> การวินิจฉัยคำเตือนแดชบอร์ด'
      ]),
      FindProblemWhereAndSolution(where: 'ไฟแต้งเตือนระบบ ABS', solution: [
        'ระบบ ABS ผิดพลาด >> การวินิจฉัยคำเตือนแดชบอร์ด',
      ]),
      FindProblemWhereAndSolution(
          where: 'ตรวจเช็คไฟแจ้งเตือนเครื่องยนต์โค้ด ',
          solution: [
            'ตรวจเช็คไฟเครื่องยนต์ (EGR Valve) >> การวินิจฉัยคำเตือนแดชบอร์ด',
          ]),
    ]),
    FindProblemDetail(fect: 'แอ่งน้ำ', whereSolution: [
      FindProblemWhereAndSolution(where: 'น้ำมันเครื่อง', solution: [
        'ฝาครอบวาล์วรั่ว >> ปรับแต่งเครื่องยนต์',
        'กรองน้ำมันเครื่องรั่ว >> เปลี่ยนถ่ายน้ำมันเครื่อง'
      ]),
      FindProblemWhereAndSolution(where: 'น้ำมันเกียร์ออโต้', solution: [
        'เลียสายส่ง >> ซ่อมเกียร์ออโต้',
        'ปะเก็นจานเกียร์รั่ว >> ซ่อมเกียร์ออโต้'
      ]),
      FindProblemWhereAndSolution(where: 'น้ำมันพวงมาลัยพาวเวอร์', solution: [
        'สายพวงมาลัยเพาเวอร์รั่ว >> ระบบบังคับเลี้ยวและช่วงล่าง',
      ]),
      FindProblemWhereAndSolution(where: 'น้ำหล่อเย็น', solution: [
        'ปั้มน้ำรั่ว >> ซ่อมระบบระบายความร้อน',
        'หม้อน้ำรั่วที่ฝา >> ซ่อมระบบระบายความร้อน',
        'ท่อหม้อน้ำรั่ว'
      ]),
    ]),
  ]),
  FindProblem(id: 2, detail: [
    FindProblemDetail(fect: 'เสียงร้อง–ต่อเนื่อง, เสียงแหลม', whereSolution: [
      FindProblemWhereAndSolution(where: 'ตลอดเวลา', solution: [
        'สายพานไดรฟ์หลวมหรือสึก >> เปลี่ยนสายพาน',
      ]),
      FindProblemWhereAndSolution(where: 'เมื่อรถหยุดนิ่ง', solution: [
        'ตัวแสดงการสึกหรอของผ้าเบรกกำลังสัมผัสกับโรเตอร์ >> การตรวจสอบเบรค',
      ]),
      FindProblemWhereAndSolution(where: 'เฉพาะเวลาสตาร์ทรถยนต์', solution: [
        'สายพานไดรฟ์หลวมหรือสึก >> เปลี่ยนสายพาน',
      ]),
      FindProblemWhereAndSolution(where: 'เฉพาะเวลาเลี้ยว', solution: [
        'ปั๊มพวงมาลัยเพาเวอร์เสีย >> ปั๊มพวงมาลัยพาวเวอร์ แร็คพวงมาลัยเพาเวอร์ ท่อพวงมาลัยเพาเวอร์ เมื่อคุณพบสาเหตุของการรั่วแล้ว คุณจะต้องเปลี่ยนส่วนประกอบนั้น',
        'สายพานไดรฟ์หลวมหรือสึก',
        'น้ำมันพวงมาลัยเพาเวอร์ต่ำ'
      ]),
      FindProblemWhereAndSolution(where: 'เฉพาะเวลารถเคลื่อนที่', solution: [
        'ตัวแสดงการสึกหรอของผ้าเบรกกำลังสัมผัสกับโรเตอร์ >> ตรวจสอบเบรก',
        'คุณภาพของผ้าเบรกและการตกแต่งโรเตอร์ >> ซ่อมดิสเบรกหน้า',
        'ผ้าเบรคชำรุด >> ซ่อมดิสเบรกหน้า'
      ]),
    ]),
    FindProblemDetail(
        fect: 'เสียงเคาะ–เสียงทุ้ม, ดัง, เสียงเหมือนเสียงเคาะประตู',
        whereSolution: [
          FindProblemWhereAndSolution(solution: [
            'ระดับน้ำมันเครื่องต่ำ >> เปลี่ยนถ่ายน้ำมันเครื่อง',
          ]),
        ]),
    FindProblemDetail(
        fect: 'เสียงแตะ-เสียงเบา ๆ ซ้ำ ๆ, ดังกว่าเสียงคลิ๊ก',
        whereSolution: [
          FindProblemWhereAndSolution(solution: [
            'ระดับน้ำมันเครื่องต่ำ >> เปลี่ยนถ่ายน้ำมันเครื่อง',
          ]),
        ]),
    FindProblemDetail(fect: 'สั่น–เหมือนมีเสียงหินข้างใน', whereSolution: [
      FindProblemWhereAndSolution(where: 'ใต้ยานพาหนะ', solution: [
        'Catalytic converterเสีย >> เปลี่ยน Catalytic converter',
        'ท่อไอเสียหลวมหรือเสียหาย >> ตรวจสอบท่อไอเสีย'
      ]),
      FindProblemWhereAndSolution(where: 'ใต้ยานพาหนะด้านหลัง', solution: [
        'ท่อไอเสียที่ชำรุดหรือหลวม >> เปลี่ยนท่อไอเสีย',
        'ปลายท่อชำรุดหรือหลวม >> ตรวจสอบท่อไอเสีย'
      ]),
      FindProblemWhereAndSolution(where: 'ห้องเครื่อง', solution: [
        'โซ่หรือสายพานไม่ดี >> เปลี่ยนสายพาน',
        'ท่อหน้าชำรุดหรือหลวม >> ตรวจสอบไอเสีย'
      ]),
    ]),
    FindProblemDetail(
        fect: 'เสียงกริ่ง–เสียงแหลมสูงซ้ำอย่างรวดเร็วเหมือนนกร้องจิ๊บๆ',
        whereSolution: [
          FindProblemWhereAndSolution(where: 'เมื่อสตาร์ทรถยนต์', solution: [
            'สายพานหลวมหรือสึก >> การเปลี่ยนสายพาน',
          ]),
          FindProblemWhereAndSolution(
              where: 'เมื่อเครื่องยนต์ทำงาน',
              solution: [
                'สายพานหลวมหรือสึก >> การเปลี่ยนสายพาน',
              ]),
          FindProblemWhereAndSolution(where: 'เมื่อรถหยุด', solution: [
            'ตัวแสดงการสึกหรอของผ้าเบรกกำลังสัมผัสกับโรเตอร์ >> การตรวจสอบเบรก',
            'ผ้าเบรคชำรุด >> ซ่อมดิสเบรกหน้า',
            'คุณภาพของผ้าเบรกหมดอายุ >> ซ่อมดิสเบรคหน้า'
          ]),
          FindProblemWhereAndSolution(
              where: 'เมื่อเร่งความเร็ว-ห้องเครื่อง',
              solution: [
                'สายพานไดรฟ์หลวมหรือสึก >>การเปลี่ยนสายพาน',
              ]),
          FindProblemWhereAndSolution(
              where: 'เมื่อเร่งความเร็ว-ใต้รถยนต์',
              solution: [
                'ผิวจานคลัตช์สึก >> การปรับคลัตช์และตรวจสอบ',
              ]),
          FindProblemWhereAndSolution(
              where: 'เมื่อเร่งความเร็ว-ไม่แน่ใจ',
              solution: [
                'ข้อต่ออ่อนสึกหรอหรือเสียหาย >> เปลี่ยนข้อต่อ',
              ]),
          FindProblemWhereAndSolution(
              where: 'เมื่อเร่งความเร็ว-จากล้อหน้า',
              solution: [
                'ข้อต่ออ่อนสึกหรอหรือเสียหาย >> เปลี่ยนข้อต่อ',
              ]),
        ]),
    FindProblemDetail(fect: 'เสียงอึกทึก–เสียงกระหึ่ม', whereSolution: [
      FindProblemWhereAndSolution(where: 'เลี้ยวซ้าย', solution: [
        'ปลายสายผูกหลวมหรือสึก >> เปลี่ยนลูกหมากคันในหรือเปลี่ยนลูกหมากนอก',
        'ลูกหมากสวมหรือ"แห้ง" >> เปลี่ยนข้อต่อลูกหมาก',
        'การประกอบแกนล้มเหลว >> การตรวจสอบเพลา cv',
        'การประกอบแกนล้มเหลว >> การตรวจสอบเพลา cv'
      ]),
      FindProblemWhereAndSolution(where: 'เลี้ยวขวา', solution: [
        'ปลายสายผูกหลวมหรือสึก >> เปลี่ยนลูกหมากคันในหรือเปลี่ยนลูกหมากนอก',
        'ลูกหมากสวมหรือ"แห้ง" >> เปลี่ยนข้อต่อลูกหมาก',
        'การประกอบแกนล้มเหลว >> ตรวจสอบเพลา cv',
        'การประกอบแกนล้มเหลว >> ตรวจสอบเพลา cv'
      ]),
      FindProblemWhereAndSolution(where: 'ไม่แน่ใจ', solution: [
        'ปลายสายผูกหลวม/สึก >> เปลี่ยนลูกหมากคันใน&เปลี่ยนลูกหมากนอก',
        'ลูกหมากสวมหรือ"แห้ง" >> เปลี่ยนข้อต่อลูกหมาก',
        'การประกอบแกนล้มเหลว >> ตรวจสอบเพลาcv',
        'การประกอบแกนล้มเหลว >> ตรวจสอบเพลาcv'
      ]),
      FindProblemWhereAndSolution(where: 'เมื่อกระแทก-ด้านหน้า', solution: [
        'ส่วนประกอบส่วนหน้าหลวมหรือสึก >> ตรวจสอบช่วงล่าง',
        'สวมสตรัท >> เปลี่ยนสตรัท'
      ]),
      FindProblemWhereAndSolution(where: 'เมื่อกระแทก-ด้านหลัง', solution: [
        'โช๊คหรือสตรัทเสื่อมสภาพ >> เปลี่ยนโช๊ค',
        'ชิ้นส่วนช่วงล่างหลวมหรือสึกหรอ >> ตรวจสอบช่วงล่าง'
      ]),
      FindProblemWhereAndSolution(where: 'เมื่อเปลี่ยนเกียร์', solution: [
        'ข้อต่อสึกหรอหรือเสียหาย >> อย่างไรก็ตาม แรงบิดและโมเมนต์ที่มากเกินไประหว่างบล็อกเครื่องยนต์กับเฟรมอาจทำให้พวกมันอ่อนลงก่อนเวลาอันควร',
        'ข้อต่อสึกหรอหรือเสียหาย >> การขาดการหล่อลื่น ความเสียหายต่อระบบขับเคลื่อน และการสึกหรอตามปกติอาจทำให้ข้อต่อเสียหายได้',
        'ความล้มเหลวในการประกอบเพลา >> การขาดจาระบีระหว่างข้อต่อ CV จะทำให้เกิดเสียงดังและเคาะเนื่องจากโลหะบนการหมุนของโลหะ แรงกดบนข้อต่อขณะเลี้ยว และการเคลื่อนไหวขึ้นลงด้วยการสั่นสะเทือนของถนน'
      ]),
    ]),
  ]),
  FindProblem(id: 3, detail: [
    FindProblemDetail(fect: 'น้ำมัน', whereSolution: [
      FindProblemWhereAndSolution(where: 'ห้องเครื่องตลอดเวลา', solution: [
        'หัวฉีดน้ำมันเชื้อเพลิงรั่ว >> หัวฉีดน้ำมันเชื้อเพลิง',
        'รางเชื้อเพลิง/ตัวปรับแรงดันน้ำมันรั่ว >> หัวฉีดน้ำมันเชื้อเพลิง'
      ]),
      FindProblemWhereAndSolution(where: 'ห้องเครื่องตลอดเวลา', solution: [
        'หัวฉีดน้ำมันเชื้อเพลิงรั่ว >> หัวฉีดน้ำมันเชื้อเพลิง',
        'รางเชื้อเพลิง/ตัวปรับแรงดันน้ำมันรั่ว >> หัวฉีดน้ำมันเชื้อเพลิง'
      ]),
    ]),
    FindProblemDetail(fect: 'ไข่เน่า', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'Catalytic converterเสีย >> อย่างไรก็ตาม อาจไม่เพียงพอต่อปัญหาอื่นๆ ที่อาจเป็นไปได้ การแก้ปัญหาสามารถทำได้ตามปกติเหมือนกับการปรับแต่งเครื่องยนต์ที่ต้องได้รับการวินิจฉัย หากไม่สามารถตรวจสอบได้ง่าย',
        'เชื้อเพลิงเต็มระบบ'
      ]),
    ]),
    FindProblemDetail(fect: 'โรคราน้ำค้าง', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'ช่องแอร์ (กลิ่นเหม็น) >> ตรวจเช็คระบบปรับอากาศ',
      ]),
    ]),
    FindProblemDetail(fect: 'สารป้องกันการแข็งตัว', whereSolution: [
      FindProblemWhereAndSolution(where: 'เมื่อฮีตเตอร์เปิด', solution: [
        'แกนเครื่องทำความร้อนรั่ว >> ตรวจเช็คระบบทำความร้อน',
      ]),
      FindProblemWhereAndSolution(
          where: 'หลังจากรถยนต์เริ่มอุ่นเครื่อง',
          solution: [
            'น้ำหล่อเย็นรั่ว (ควัน) >> อย่างไรก็ตาม อาจเกิดความล้มเหลวได้หากปล่อยน้ำหล่อเย็นทิ้งไว้โดยไม่มีบริการ ความเสียหายจากการชน หรือทำให้รถร้อนเกินไป เพื่อยืดอายุหม้อน้ำ น้ำหอม บำรุงรักษาตามระยะในระบบหล่อเย็น',
          ]),
    ]),
    FindProblemDetail(fect: 'น้ำมันไหม้', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'น้ำมันเครื่องรั่ว >> ปรับแต่งเครื่องยนต์',
      ]),
    ]),
    FindProblemDetail(fect: 'ไอเสีย', whereSolution: [
      FindProblemWhereAndSolution(where: 'ภายในรถยนต์', solution: [
        'ปะเก็นท่อร่วมไอเสียรั่ว >> เกิดได้หลายต่ำแหน่ง',
        'ท่อไอเสียรั่ว (ท่อหน้า) >> การตรวจสอบท่อไอเสีย'
      ]),
      FindProblemWhereAndSolution(where: 'ภายนอกรถยนต์', solution: [
        'ระบบไอเสียรั่ว >> ตรวจสอบท่อไอเสีย',
      ]),
    ]),
  ]),
  FindProblem(id: 4, detail: [
    FindProblemDetail(fect: 'ดริฟต์–ค่อย ๆ เคลื่อนไปข้างหนึ่ง', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'ส่วนประกอบส่วนหน้าหลวมหรือสึก >> ตรวจสอบช่วงล่าง',
        'แรงดันลมยางไม่เท่ากัน >> ซ่อม TPMS',
        'ล้อไม่ตรงตำแหน่ง >> ตั้งศูนย์สี่ล้อ'
      ]),
    ]),
    FindProblemDetail(
        fect: 'เล่นมากเกินไป–หลวม, พวงมาลัยไม่ตอบสนอง',
        whereSolution: [
          FindProblemWhereAndSolution(solution: [
            'ปลายสายผูกหลวม/สึก >> เปลี่ยนลูกหมากคันในและปลี่ยนลูกหมากนอก',
          ]),
        ]),
    FindProblemDetail(
        fect: 'ดึง–การเคลื่อนไหวที่ไปข้างใดข้างหนึ่ง',
        whereSolution: [
          FindProblemWhereAndSolution(solution: [
            'ส่วนหน้าหลวมหรือสึกหรอ >> ตรวจสอบช่วงล่าง',
            'เบรกหน้าลาก >> ซ่อมดิสก์เยรคหน้า',
            'ล้อไม่ตรงตำแหน่ง >> ตั้งศูนย์สี่ล้อ',
            'แรงดันลมยางหน้าไม่เท่ากัน >> ซ่อม TPMS'
          ]),
        ]),
    FindProblemDetail(fect: 'ดริฟต์–ค่อย ๆ เคลื่อนไปข้างหนึ่ง', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'ส่วนประกอบส่วนหน้าหลวมหรือสึก >> ตรวจสอบช่วงล่าง',
        'แรงดันลมยางไม่เท่ากัน >> ซ่อม TPMS',
        'ล้อไม่ตรงตำแหน่ง >> ตั้งศูนย์สี่ล้อ'
      ]),
    ]),
    FindProblemDetail(
        fect: 'เป็นจังหวะ–ความผันผวนของแป้นเบรกเมื่อเหยียบเบรก',
        whereSolution: [
          FindProblemWhereAndSolution(solution: [
            'จานเบรคบิดเบี้ยว >> เปลี่ยนจานเบรก',
            'ออกจากดรัมเบรคกลม >> ซ่อมดรัมเบรคหลัง',
          ]),
        ]),
    FindProblemDetail(
        fect:
            'Shimmy–การเคลื่อนที่อย่างรวดเร็วจากด้านหนึ่งไปอีกด้านหนึ่งของล้อหน้า',
        whereSolution: [
          FindProblemWhereAndSolution(solution: [
            'ส่วนประกอบส่วนหน้าหลวมหรือสึก >> การตรวจสอบช่วงล่าง',
          ]),
        ]),
    FindProblemDetail(
        fect: 'แกว่งไปแกว่งมา-ค่อย ๆ เคลื่อนไหวจากด้านในไปด้านข้าง',
        whereSolution: [
          FindProblemWhereAndSolution(solution: [
            'โช๊ค/สตรัทเสื่อมสภาพ >> เปลี่ยนโช๊ค',
            'ชิ้นส่วนช่วงล่างหลวมหรือสึกหรอ >> ตรวจสอบช่วงล่าง',
          ]),
        ]),
    FindProblemDetail(
        fect: 'การสั่นสะเทือน-รถสั่น. มักจะรู้สึกได้บนพวงมาลัยหรือเบาะนั่ง',
        whereSolution: [
          FindProblemWhereAndSolution(
              where: 'ผ่านพวงมาลัย เมื่อเบรก',
              solution: [
                'จานเบรคบิดเบี้ยว >> เปลี่ยนจานเบรค',
                'ส่วนประกอบส่วนหน้าหลวมหรือสึก >> ตรวจสอบช่วงล่าง',
              ]),
          FindProblemWhereAndSolution(
              where: 'ผ่านที่นั่ง เมื่อเบรก',
              solution: [
                'ออกจากดรัมเบรคกลม >> ซ่อมดรัมเบรคหลัง',
              ]),
          FindProblemWhereAndSolution(where: 'ไม่แน่ใจ เมื่อเบรก', solution: [
            'จานเบรคบิดเบี้ยว >> เปลี่ยนจานเยรค',
            'ออกจากดรัมเบรคกลม >> ซ่อมดรัมเบรกหลัง',
            'ส่วนประกอบส่วนหน้าหลวมหรือสึก >> การตรวจสอบช่วงล่าง'
          ]),
          FindProblemWhereAndSolution(
              where: 'เมื่อเร่งความเร็วจากหยุดนิ่ง เมื่อเบรก',
              solution: [
                'ส่วนประกอบส่วนหน้าหลวมหรือสึก >> การตรวจสอบช่วงล่าง',
              ]),
          FindProblemWhereAndSolution(
              where: 'อย่างต่อเนื่องเมื่อเดินทางด้วยความเร็วสูง เมื่อเบรก',
              solution: [
                'ล้อหน้าไม่สมดุล (น้ำหนักล้อลดลง) >> ถ่วงล้อด้วยคอมพิวเตอร์',
                'ส่วนประกอบส่วนหน้าหลวมหรือสึก >> การตรวจสอบช่วงล่าง',
                'ขอบล้องอ >> ซื้อล้อและติดตั้งล้อ'
              ]),
        ]),
  ]),
  FindProblem(id: 5, detail: [
    FindProblemDetail(
        fect: 'เครื่องบนต์หมุนปกติแต่สตาร์ทไม่ติด',
        whereSolution: [
          FindProblemWhereAndSolution(solution: [
            'ไม่มีแรงดันน้ำมันเชื้อเพลิง >> เติมน้ำมันเชื้อเพลิง',
            'โซ่หรือสายพานไม่ดี >> เปลี่ยนสายพาน',
            'ไม่มีประกายไฟ >> ปรับแต่งเครื่องยนต์'
          ])
        ]),
    FindProblemDetail(fect: 'เครื่องบนต์หมุนช้า', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'แบตเตอรี่อ่อน >> เปลี่ยนแบตเตอรี่',
        'ขั้วแบตเตอรี่สึกกร่อน >> เปลี่ยนแบตเตอรี่',
        'ตัวสตาร์ทไม่ดี >> เปลี่ยน starter '
      ])
    ]),
    FindProblemDetail(fect: 'รถกำลังถอยหลังเมื่อพยายามสตาร์ท', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'ตัวจุดระเบิดไม่ดี >> ปรับแต่งเครื่องยนต์',
        'โซ่หรือสายพานไม่ดี >> เปลี่ยนสายพาน',
      ])
    ]),
    FindProblemDetail(fect: 'ไม่มีอะไรเลย', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'แบตเตอรี่หมด >> เปลี่ยนแบตเตอรี่',
        'ขั้วแบตเตอรี่สึกกร่อน >> เปลี่ยนแบตเตอรี่',
        'ตัวสตาร์ทไม่ดี >> เปลี่ยน starter',
        'สวิตช์จุดระเบิดผิดพลาด >> เช็คระบบสตาร์ทและชาร์จ'
      ])
    ]),
    FindProblemDetail(
        fect: 'คลิกที่หนักหนึ่งครั้งหรือเสียงเคาะ',
        whereSolution: [
          FindProblemWhereAndSolution(solution: [
            'ตัวสตาร์ทไม่ดี >> เปลี่ยน starter ',
          ])
        ]),
    FindProblemDetail(fect: 'เสียงหมุน เหวี่ยงหรือฟันเฟือง', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'ตัวสตาร์ทไม่ดี >> เปลี่ยน starter ',
      ])
    ]),
    FindProblemDetail(fect: 'เสียงลิกซ้ำ : คลิก คลิก คลิก', whereSolution: [
      FindProblemWhereAndSolution(solution: [
        'แบตเตอรี่อ่อน >> เปลี่ยนแบตเตอรี่',
        'ขั้วแบตเตอรี่สึกกร่อน >> เปลี่ยนแบตเตอรี่',
        'ตัวสตาร์ทไม่ดี >> เปลี่ยน starter '
      ])
    ]),
  ])
];
