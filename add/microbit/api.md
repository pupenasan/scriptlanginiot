# Посібник

https://makecode.microbit.org/reference

## basic 

### showNumber

Покажіть число на світлодіодному екрані. Він буде ковзати вліво, якщо він містить більше однієї цифри.

```js
for (let i = 0; i < 6; i++) {
    basic.showNumber(i)
    basic.pause(200)
}
```

### Show Icon

Показує вибрану піктограму на світлодіодному екрані

```js
basic.forever(function () {
    basic.showIcon(IconNames.Heart)
    basic.showIcon(IconNames.SmallHeart)
})
```

### Show LEDs

Показує зображення на світлодіодному екрані.

```js
basic.showLeds(`
    # # . # #
    # # . # #
    . # # # .
    . # . # .
    . # . # .
    `
)
```

Якщо ви програмуєте на JavaScript, `#` означає світлодіод, який увімкнено та `.` означає світлодіод, який вимкнено.

### Show String

Покажіть рядок на світлодіодному екрані. Він буде прокручуватися вліво, якщо він більший за екран.

```js
let s = "Hi" basic.showString(s)
```

### Clear Screen

```js
basic.showLeds(`
. # . # . 
# # # # # 
# # # # # 
. # # # . 
. . # . . 
`)
basic.clearScreen()
```

### forever

Продовжуйте виконувати частину програми у фоновому режимі.

Ви можете мати частину програми безперервно, помістивши її у вічний цикл. Цикл назавжди поступатиметься іншому коду у вашій програмі, дозволяючи цьому коду мати час для запуску, коли це необхідно.

```js
basic.forever(() => {
    basic.showNumber(6789)
})
input.onButtonPressed(Button.A, () => {
    basic.showNumber(2)
})
```

Цикли на основі подій. І цикл `forever`, і цикл `every` — це цикли на основі подій, де код усередині виконується як частина функції. Вони відрізняються від циклів `for` і `while`. Ці цикли є частиною мови програмування і можуть містити оператори break і continue. Ви НЕ можете використовувати break або continueні в циклі `forever`, ні в циклі `every`.

### Pause

Призупиніть програму на вказану вами кількість мілісекунд. Ви можете використовувати цю функцію для уповільнення роботи програми

```js
let duration = 500
basic.forever(function () {
    led.toggle(randint(0, 4), randint(0, 4))
    basic.pause(duration)
})
```

### Show Arrow

Показує вибрану стрілку на світлодіодному екрані

```js
for (let index = 0; index <= 7; index++) {
    basic.showArrow(index)
    basic.pause(300)
}
```

## input

Події та дані від датчиків

### On Button Pressed

Запустіть обробник подій (частина програми, яка запускатиметься, коли щось станеться, наприклад, коли натиснуто кнопку). Цей обробник працює, коли натиснуто кнопку `A` або `B`, або `A` і `B` разом. Коли ви використовуєте цю функцію у веб-браузері, натискайте кнопки на екрані замість кнопок на micro:bit.

Для кнопки `A` або `B`: цей обробник працює, коли кнопку натискають і відпускають протягом 1 секунди.
Для `A` і `B` разом: цей обробник працює, коли `A` і `B` обидва натиснуті вниз, а потім один із них відпускається протягом 1,5 секунд після натискання другої кнопки.

```js
input.onButtonPressed(Button.B, () => {
    let dice = randint(0, 5) + 1
    basic.showNumber(dice)
})
```

### On Gesture

Запустіть обробник подій (частина програми, яка запускатиметься, коли щось станеться). Цей обробник працює, коли ви робите жест (наприклад, струшування micro:bit).

`gesture` means the way you hold or move the micro:bit. This can be `shake`, `logo up`, `logo down`, `screen up`, `screen down`, `tilt left`, `tilt right`, `free fall`, `3g`, or `6g`.

```
function input.onGesture(gesture: Gesture, body: () => void): void;
```

```js
input.onGesture(Gesture.Shake,() => {
    let x = randint(2, 9)
    basic.showNumber(x)
})
```

