---
title: Excel 中数字和日期之间的转换规则 
date: 2013/03/23 22:51:18
categories: Tech
---
我们在 Microsoft Excel 单元格中看到的日期，很多时候在其内部是表示为数字的。可能很多人注意到了，当我们改变单元格的格式化选项时，单元格的显示内容有时会立刻发生变化。

例如此刻的时间是 2013-03-23 21:37:01，当将这段文字输入 Excel 后，我们右键->设置单元格格式，会发现显示的是“自定义”的格式，根据不同的兼容版本，可能是类似 yyyy-m-d h:mm 这样的表示。然后我们将格式设置为“文本”，会发现其实际数值是 41356.900706。

这两者之间是如何联系起来的？对于普通用户来说，可能不会也不用关心；但是对于偶尔跟 Excel 打交道的程序员来说，可能需要了解这其中的关系。前段时间我就碰到了这个问题，将一个通过通用接口从 Excel 中取出的数字，转为标准的 Java 日期。经过一番猜测，我的同事和我一起找出了其中的规律：

1. 浮点数的整数部分是代表1900年1月1日至今所经过的天数-1，例如 1 代表1900年1月1日；
2. 浮点数的小数部分，乘以24，所得积的整数部分为额外经过的小时数；
3. 上一步所得积的小数部分，乘以60，所得积的整数部分为额外经过的分钟数；
4. 上一步所得积的小数部分，乘以60，向上取整，为额外经过的秒数。

需要注意的是，整数部分所代表的日期几乎总是比实际情况多了1天，例如 1900年3月1日应该表示为 60，但实际却是61。这是因为 Excel 认为 1900年的2月有29天，而事实上却并没有。不过先不要着急责怪 Excel，这个 BUG 是一个名为 Lotus 的软件制造的（遥远的时代，未曾经历 :D），在 Excel发布的时候，Lotus 几乎是市场上的事实标准， Excel为了与其保持兼容，也就【人工制造】了这个 BUG。向上兼容，也许是微软最值得夸耀的事情。

我们用前面得到的数字 41356.900706，以 JAVA 代码为例，逐步转换：

    Calendar calendar = Calendar.getInstance();
    // 设置为1900年1月1日
    calendar.set(Calendar.YEAR, 1900);
    calendar.set(Calendar.DAY_OF_YEAR, 1);

    Double dateNumber = 41356.900706D;

    // 天数减了2，一个1是指起点是1，另一个1是指 Excel 将天数多算了1
    calendar.add(Calendar.DAY_OF_YEAR, dateNumber.intValue() - 2);

    // 小数部分乘以24后向下取整，是为小时
    dateNumber = (dateNumber - dateNumber.intValue()) * 24;
    calendar.set(Calendar.HOUR_OF_DAY, dateNumber.intValue());

    // 上一步所的积的小数部分乘以60后向下取整，是为分钟
    dateNumber = (dateNumber - dateNumber.intValue()) * 60;
    calendar.set(Calendar.MINUTE, dateNumber.intValue());

    // 上一步所得积的小数部分乘以60后向上取整，是为秒
    dateNumber = (dateNumber - dateNumber.intValue()) * 60;
    calendar.set(Calendar.SECOND, (int) Math.round(dateNumber));

    System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        .format(calendar.getTime()));
    // 结果为 2013-03-23 21:37:01

参考：[Dates And Times In Excel](http://www.cpearson.com/excel/datetime.htm)

