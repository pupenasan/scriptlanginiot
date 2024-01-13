# Аналіз даних

https://github.com/microsoft/pxt-microbit/blob/master/docs/device/data-analysis.md

# Writing data

Коли ви використовуєте MakeCode, усі дані, записані функціями [serial](https://github.com/microsoft/pxt-microbit/blob/master/reference/serial), записуються редактором MakeCode. Це трапляється, коли ви пробуєте свій код у симуляторі, а також коли @boardname@ підключено до комп’ютера, на якому запущено програму MakeCode через USB.

## Data formats

Засіб перегляду даних розпізнає формат виведених даних і вирішує, як їх відображати. Якщо ваші дані є *потоком* значень, вони відображатимуться у вікні діаграми та відображатимуться як текст у консолі. Якщо ваші дані – це лише текстова інформація, вона з’являється лише у вікні консолі.

You can write data in these format types:

- Text ([string](https://github.com/microsoft/pxt-microbit/blob/master/types/string)): `"Hello there!"`
- [Numbers](https://github.com/microsoft/pxt-microbit/blob/master/types/number): `"354"`
- [Number arrays](https://github.com/microsoft/pxt-microbit/blob/master/types/array): `"11,3,45,76"`
- Name value pairs: `"accelY:956"`

## Text output

Текст формується простим використанням рядкових даних. Текстові дані не записуються в консоль, доки не буде написаний повний «рядок» тексту. Рядок — це просто рядок із деякими спеціальними символами (тими, які ви насправді не бачите надрукованими) у кінці. Ви можете написати кілька рядків, наприклад:

```block
serial.writeString("Hello ");
serial.writeString("from ")
serial.writeString("micro:bit")   
```

Цей текст, однак, не з’явиться на консолі редактора, доки він не стане повним рядком. Якщо ви стежите за записом рядка з рядком у вашому коді, тоді рядок відобразиться:

```block
serial.writeString("Hello ")
serial.writeString("from ")
serial.writeString("micro:bit")
serial.writeLine("")   
```

Text output is used mostly for messages since number formats have meaning when used for data analysis.

The blank `||serial:serial write line||` adds  the special line ending characters and turns the previous strings into a complete line of text. The whole line could simply be written out with  just one function:

```block
serial.writeLine("Hello from micro:bit")
```

When you're writing only text, it appears  only in the console view and not in the chart window. This example  writes four messages of text:

```block
for (let i = 0; i < 4; i++) {
    serial.writeLine("Hello from micro:bit " + i)
}
```

## Writing numbers

Щоб програма перегляду даних розпізнала число як значення та відобразила його на діаграмі, воно має бути в окремому рядку. Отже, числа, записані окремо, не будуть нанесені на діаграму:

```block
serial.writeNumber(1)
serial.writeNumber(2)
serial.writeNumber(3)  
```

The numbers don't show up as single values because they appear in the output as a string: `"123"`. Also, the string doesn't form a complete line so it doesn't show up in  the console window either. You could add a blank line to the numbers  already written. If you did this, you would have just one value charted  which is `123`:

Числа не відображаються як окремі значення, оскільки вони відображаються у виведених даних як рядок: "123". Крім того, рядок не утворює повний рядок, тому він також не відображається у вікні консолі. Ви можете додати порожній рядок до вже написаних чисел. Якби ви зробили це, у вас було б лише одне значення на діаграмі, яке дорівнює `123`:

```block
serial.writeNumber(1)
serial.writeNumber(2)
serial.writeNumber(3)
serial.writeLine("")
```

Here's a way to chart the numbers individually:

```block
for (let i = 0; i < 4; i++) {
    serial.writeNumber(i)
    serial.writeLine("")
}    
```

It's much better though to use a value stream by writing the numbers as [name value pairs](https://github.com/microsoft/pxt-microbit/blob/master/docs/device/data-analysis/writing.md#name-value-pairs).

## Number arrays

Numbers in arrays are displayed on separate data lines on the same chart. You can use `||serial:serial write numbers||` to write several values at once. The numbers are written to the output as *comma separated values* (CSV). The array of numbers:

Числа в масивах відображаються в окремих рядках даних на одній діаграмі. Ви можете використовувати `||serial:serial write numbers||`, щоб записати кілька значень одночасно. Числа записуються у вивід як *значення, розділені комами* (CSV). Масив чисел:

```block
let values = [0,1,2,3,4];
```

is written to the output in the form of a CSV string as: `"0,1,2,3,4"`.

The Data Viewer recognizes this as an array of numbers and charts them on separate data lines:

```block
let values = [0, 1, 2, 3, 4]
basic.forever(() => {
    serial.writeNumbers(values)
})
```

Give this example a try and watch the chart make a diamond pattern from two triangle waves:

```blocks
let diamond: number[] = []
basic.forever(() => {
    for (let i = 0; i <= 10 - 1; i++) {
        if (i < 5) {
            diamond[0] = i
            diamond[1] = 5 - i
        } else {
            diamond[0] = 10 - i
            diamond[1] = i - 5
        }
        serial.writeNumbers(diamond)
        basic.pause(500)
    }
})
```

## Name value pairs

A very common way to report and record data is to use a *name value pair* (NVP). A value is given a name so you know what it's for or where it  came from. The name value pair is written with the format of *name:value*. There is a name, a colon character, and the value all together on one  line. The line is written to the output and the Data Viewer recognizes  it as a value and charts it as part of a value stream. The value stream  is based on the name so any new values received with the same name are  displayed on the chart that's showing values for that name. If more than one type of name value pair is found, the Data Viewer makes another  value stream and shows those values on a different chart.

If you want to report the values for both temperature and  light, you can make separate name value pairs for them. The name value  pairs are written using `||serial:serial write value||`. This function writes the values to the output as lines in a format like this:

```
temp:17
light:118
temp:18
light:117
```

​    

```blocks
basic.forever(() => {
    serial.writeValue("temp", input.temperature())
    serial.writeValue("light", input.lightLevel())
    basic.pause(5000)
})
```

​    

Two charts display each value stream:

[![Two charts for each value type](https://github.com/microsoft/pxt-microbit/raw/master/static/mb/device/data-analysis/two-value-chart.jpg)](https://github.com/microsoft/pxt-microbit/blob/master/static/mb/device/data-analysis/two-value-chart.jpg)

The console output shows the different name value pairs too:

[![Two values in console output](https://github.com/microsoft/pxt-microbit/raw/master/static/mb/device/data-analysis/two-value-console.jpg)](https://github.com/microsoft/pxt-microbit/blob/master/static/mb/device/data-analysis/two-value-console.jpg)

### 

### Writing subvalues

Similar to number arrays, different name value pairs are shown on one chart by using *subvalues*. You make a subvalue by combining a first-level name and a second-level name with a `'.'`:

```
"firstLevel.secondLevel"
```

The first-level name is value name for the chart. The second-level name is the name for the actual value displayed.

If you want to show all three values of acceleration on a single chart, then use each axis as a second-level (subvalue) name, `"acceleration.x"`.

```block
serial.writeValue("acceleration.x", input.acceleration(Dimension.X))
```

​    

To show the values for each axis together:

```blocks
basic.forever(() => {
    serial.writeValue("acceleration.x", input.acceleration(Dimension.X))
    serial.writeValue("acceleration.y", input.acceleration(Dimension.Y))
    serial.writeValue("acceleration.z", input.acceleration(Dimension.Z))
    basic.pause(500)
}) 
```

​    

Each subvalue `'x'`, `'y'`, and `'z'` is displayed on the chart named `"acceleration"` in the Data Viewer.

[![Three subvalues of acceleration in one chart](https://github.com/microsoft/pxt-microbit/raw/master/static/mb/device/data-analysis/combined-values.jpg)](https://github.com/microsoft/pxt-microbit/blob/master/static/mb/device/data-analysis/combined-values.jpg)