# Використання JavaScript в MakeCode 

https://makecode.microbit.org/javascript

Середовище програмування Microsoft MakeCode використовує JavaScript разом із мовою Static Type Script. Ці теми містять короткий вступ до JavaScript за допомогою MakeCode:

- **[Calling](https://makecode.microbit.org/javascript/call)** - як користуватися функцією
- **[Sequencing](https://makecode.microbit.org/javascript/sequence)** - упорядкування операторів у коді
- **[Variables](https://makecode.microbit.org/javascript/variables)** - запам'ятовувати дані та зберігати значення
- **[Operators](https://makecode.microbit.org/javascript/operators)** - операції для зміни та порівняння значень
- **[Statements](https://makecode.microbit.org/javascript/statements)** - елементи коду, які виконують дії
- **[Functions](https://makecode.microbit.org/javascript/functions)** - Частини коду для використання знову і знову
- **[Types](https://makecode.microbit.org/javascript/types)** - Ідентичність даних
- **[Classes](https://makecode.microbit.org/javascript/classes)** - містять пов’язані дані та операції разом
- **[Interfaces](https://makecode.microbit.org/javascript/interfaces)** - звичайний спосіб роботи з класом
- **[Generics](https://makecode.microbit.org/javascript/generics)** - використовуйте різні дані з однаковим кодом

https://makecode.com/language

Програми MakeCode можна створювати на Blocks, Static TypeScript або Static Python.

І Blocks, і Static Python перетворюються на Static TypeScript перед компіляцією в мови нижчого рівня. Blocks реалізовано за допомогою Google Blockly.

Static TypeScript є підмножиною [TypeScript](https://www.typescriptlang.org/). Зараз ми використовуємо TypeScript версії 2.6.1. Сам TypeScript є надмножиною JavaScript, і багато програм MakeCode, особливо на рівні початківців, також є звичайним JavaScript. У цьому документі MPLR 2019 є додаткові технічні відомості про мову та компілятор.

MakeCode призначений спочатку для навчання програмуванню, а потім для JavaScript. З цієї причини ми трималися подалі від концепцій, які є специфічними для JavaScript (наприклад, успадкування прототипів), і натомість зосередилися на тих, які є спільними для більшості сучасних мов програмування (наприклад, цикли, змінні з лексичною областю видимості, функції, лямбда-вирази, класи) .

## Підтримувані мовні функції

- variable declarations with `let`, `const`
- functions with lexical scoping and recursion
- top-level code in the file; hello world really is `console.log("Hello world")`
- `if ... else if ... else` statements
- `while` and `do ... while` loops
- `for(;;)` loops
- `for ... of` statements (see below about `for ... in`)
- `break/continue`; also with labeled loops
- `switch` statement (on numbers, strings, and arbitrary types - the last one isn’t very useful)
- `debugger` statement for breakpoints
- conditional operator `? :`; lazy boolean operators
- namespaces (a form of modules) 
- all arithmetic operators (including bitwise operators)
- strings (with a few common methods)
- [string templates](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals) (``x is ${x}``)
- arrow functions `() => ...`
- passing functions (with up to 3 arguments) as values
- classes with static and instance fields, methods and constructors; `new` keyword
- array literals `[1, 2, 3]`
- enumerations (`enum`)
- asynchronous functions that look [synchronous to the user](https://makecode.com/async)
- method-like properties (get/set accessors)
- basic generic classes, methods, and functions
- class inheritance
- classes implementing interfaces (explicitly and implicitly)
- object literals `{ foo: 1, bar: "two" }`
- `typeof` expression
- `public`/`private` annotations on constructor arguments (syntactic sugar to make them into fields)
- initializers for class fields
- lambda functions with more than three arguments
- using generic functions as values and nested generic functions
- binding with arrays or objects: `let [a, b] = ...; let { x, y } = ...`
- exceptions (`throw`, `try ... catch`, `try ... finally`)
- downcasts of a superclass to a subclass
- function parameter bi-variance
- explicit or implicit use of the `any` type
- `union` or `intersection` types
- using a generic function as a value
- class inheritance for generic classes and methods
- `delete` statement (on object created with `{...}`)
- object destructuring with initializers
- shorthand properties (`{a, b: 1}` parsed as `{a: a, b: 1}`)
- computed property names (`{[foo()]: 1, bar: 2}`)

## Непідтримувані мовні функції

Static TypeScript has *nominal typing* for classes, rather than the *structural typing* of TypeScript. In particular, it does not support:

- `interface` with same name as a `class`
- casts of a non-`class` type to a `class`
- `interface` that extends a a `class`
- inheriting from a built-in type
- `this` used outside of a method
- function overloading

Things you may miss and we may implement:

- spread and reset operators (statically typed)
- support of `enums` as run-time arrays
- `new` on non-class types
- using a built-in function as a value

Речі, які ми навряд чи впровадимо через обсяг проекту чи інші обмеження (зауважте, що якщо ви не знаєте, що таке дана функція, ви навряд чи пропустите її):

- file-based modules (`import * from ...`, `module.exports` etc); ми підтримуємо простори імен
- `yield` expression and `function*`
- `await` expression and `async function`
- tagged templates `tag `text ${expression} more text`` are limited to special compiler features like image literals; regular templates are supported
- `with` statement
- `eval`
- `for ... in` statements (`for ... of` is supported)
- prototype-based inheritance; `this` pointer outside classes
- `arguments` keyword; `.apply` method
- JSX (HTML fragments as part of JavaScript)

Статичний TypeScript має дещо суворіші ідеї означення області, ніж звичайний TypeScript. Зокрема, `var` не дозволяється (підтримуються `let` і `const`), а ідентифікатори, означені за допомогою `function`, можна використовувати лише після означення всіх змінних із зовнішніх областей. (Об’єкти закриття для функцій, які використовуються перед визначенням, створюються одразу після визначення останньої використовуваної змінної. Для функцій, визначених перед використанням, закриття створюється в точці визначення.) Обидва наведені нижче приклади призведуть до помилки компіляції.

```typescript
function foo1() {
    bar()
    let x = 1
    function bar() {
        let y = x // runtime error in JavaScript
    } 
}
function foo1() {
    const tmp = bar
    let x = 1
    tmp() // no runtime error in JavaScript
    function bar() { let y = x } 
}
```

Для цілей лише JS ми можемо реалізувати наступне:

- регулярні вирази

Зауважте, що ви можете використовувати все це під час впровадження свого середовища виконання (симулятора), вони просто не можуть використовуватися в програмах користувача.

## Семантичні відмінності від JavaScript

Таким чином, неможливо запустити повноцінну віртуальну машину JavaScript у 3 Кб оперативної пам’яті, тому програми PXT статично скомпільовані у рідний код для ефективної роботи.

Раніше PXT підтримував *застарілу стратегію компіляції*, де числа представлялися як 32-розрядні цілі числа зі знаком, а всі типи були статичними. Це використовується гілкою `v0` micro:bit (але не поточною `v1`) і редакторами Chibitronics, але більше не включено до основної кодової бази PXT.

PXT дотримується номінальної типізації для класів. Це означає, що якщо ви оголошуєте `x` класом типу `C`, а під час виконання він не має цього типу, тоді, коли ви намагаєтеся отримати доступ до полів або методів `x`, ви отримаєте виняток, просто ніби `x` було `null`.

Також неможливо [monkey-patch](https://en.wikipedia.org/wiki/Monkey_patch) класи шляхом перевизначення методів екземпляра класу. Оскільки ланцюжки прототипів недоступні або навіть не використовуються, їх також неможливо виправити.

Нарешті, класи наразі не розширюються довільними полями. Ми можемо скасувати це в майбутньому.

`Object.keys(x)` ще не підтримується, якщо `x` є динамічним типом класу. Він підтримується, коли `x` було створено з об’єктним літералом (наприклад, `{}` або `{ a: 1, b: "foo" }`). Порядок, у якому повертаються властивості, є порядком вставки без особливої уваги до ключів, які виглядають як цілі числа (JavaScript має [справді неінтуїтивну поведінку](https://www.stefanjudis.com/today-i-learned/property-order-is-predictable-in-javascript-objects-since-es2015/) тут). Коли ми підтримуємо `Object.keys()` для типів класів, порядок буде статичним порядком визначення поля.

## Середовища виконання

Програми PXT виконуються принаймні в трьох різних середовищах:

- мікроконтролери з власною компіляцією коду (ARM)
- браузери
- механізми JavaScript на стороні сервера (node.js тощо)

Ми називаємо середовище виконання браузера «симулятором» (мікроконтролера), хоча для деяких цілей це єдине середовище.

Виконання node.js наразі використовується лише для автоматизованого тестування, але можна легко уявити досвід програмування для сценаріїв, що виконуються на безголових пристроях, локально або в хмарі.

У випадку мікроконтролерів програми PXT [компілюються у браузері](https://www.touchdevelop.com/docs/touch-develop-in-208-bits) у збірку ARM Thumb, а потім у машинний код, у результаті чого файл, який потім розгортається на мікроконтролері, зазвичай [через інтерфейс накопичувача USB](https://makecode.com/blog/one-chip-to-flash-them-all).

Для браузерів і node.js програми PXT скомпільовано в [continuation-passing style](https://en.wikipedia.org/wiki/Continuation-passing_style) JavaScript. Це використовує дерево абстрактного синтаксису TypeScript як вхідні дані, але не використовує джерело JavaScript TypeScript. Позитивним є те, що це дозволяє [обробку асинхронних викликів](https://makecode.com/async), навіть якщо браузер не підтримує оператор `yield`, а також кросбраузерність і віддалене налагодження. З іншого боку, згенерований код насправді не читається людиною.

Числа є або [позначеними 31-розрядними цілі числами зі знаком](https://makecode.com/js/values), або, якщо вони не підходять, подвійними числами. Спеціальним константам, таким як `false`, `null` і `undefined`, надаються спеціальні значення, і їх можна розрізняти. Ми прагнемо до повної сумісності з JavaScript.

## Статична компіляція проти динамічної віртуальної машини

Програми PXT скомпільовані у власний код. Єдина наразі підтримувана нативний пристрій – це ARM Thumb. Раніше PXT підтримував два різні порти AVR, але їх було видалено разом із застарілою стратегією компіляції.

Порівняно з типовим динамічним движком JavaScript, PXT компілює код статично, що значно покращує продуктивність часу та простору:

- user programs are compiled directly to machine code, and are never in any byte-code form that needs to be interpreted; this results in much faster execution than a typical JS interpreter
- there is no RAM overhead for user-code - all code sits in flash; in a dynamic VM there are usually some data-structures representing code
- due to lack of boxing for small integers and static class layout the memory consumption for objects is around half the one you get in a dynamic VM (not counting the user-code structures mentioned above)
- while there is some runtime support code in PXT, it’s typically around 100KB smaller than a dynamic VM, bringing down flash consumption and leaving more space for user code

The execution time, RAM and flash consumption of PXT code is as a rule of thumb 2x of compiled C code, making it competitive to write drivers and other user-space libraries.

Interfacing C++ from PXT is easier than interfacing typical dynamic VMs, in particular for simple functions with numbers on input and output - there is no need for unboxing, checking types, or memory management.

The main disadvantage of using static compilation is lack of dynamic features in the language (think `eval`), as explained above.

While it is possible to run a dynamic VM even on an nRF51-class device (256KB of flash, 16KB of RAM), it leaves little space for innovative features on the software side, or more complex user programs and user-space (not C++) drivers.

## Smaller int types

As noted above, when performing computations numbers are treated as doubles.  However, when you store numbers in global variables or (soon) record fields you can choose to use a smaller int type to save memory. Microcontrollers typically have very  little memory left, so these few bytes saved here and there (especially in commonly  used packages) do add up.

The supported types are:

- `uint8` with range `0` to `255`
- `uint16` with range `0` to `65536`
- `int8` with range `-128` to `127`
- `int16` with range `-32768` to `32767`
- `int32` with range `-2147483648` to `2147483647`
- `uint32` with range `0` to `4294967295`

If you attempt to store a number exceeding the range of the small int type, only the lowest 8 or 16 bits will be stored. There is no clamping nor overflow exceptions.

If you just use `number` type (or specify no type at all) in tagged strategy, then if the number fits in signed 31 bits, 4 bytes of memory will be used. Otherwise, the 4 bytes will point to a heap-allocated double (all together, with memory allocator overhead, around 20 bytes).

In legacy strategy, `number` is equivalent to `int32`, and there is no `uint32`.

### Limitations

- arrays of int types are currently not supported; you can use a `Buffer` instead
- locals and parameters of int types are not supported

## Near future work

There are following differences currently, which should be fixed soon. They are mostly missing bridges between static, nominally typed classes, and dynamic maps.

- default parameters are resolved at call site; they should be resolved in the called method so eg. virtual methods can have different defaults
- `x.foo`, where `x` is class and `foo` is method cannot be currently used as a value; we could make it equivalent to JavaScript’s `x.foo.bind(x)`
- `Object.keys()` is currently not implemented for classes; when it will be the order of fields will be static declaration order
- how to validate types of C++ classes (Pin mostly)?
