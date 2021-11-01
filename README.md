# Комментарии #

### Порядок действий для запуска ###

---

1. Выставление настроек перед компиляцией и тестами:

	1.1 Выставить настройки RTL через 'fht_defines.v' (тест миксеров, требуется ли округление данных и т.д.)

	1.2 Через TCL определить кол-во точек преобразования: оно определяется кол-ом слов в одном банке RAM, 
		т.о. изменяя битность адресации одного банка RAM меняется кол-во точек преобразования в соответствии с таблицей

	1.3 Задать битность входных данных (ADC), битность коэффициентов (W, IMP), кол-во точек, которые записываются в RAM для свёртки (Nx), также TCL генерирует sin/cos коэф. в авт. режиме

	1.4 Перед компиляцией проверить режим теста миксеров, т.к. он отключает часть RTL (в командной строке TCL выведется сообщение) и 
		его требуется выключить перед финальной компиляцией рабочей версии

	1.5 Компиляцию осуществлять только через TCL с ключом '-c'
		1.5.0 Загрузив в консоль TCL функцию для использования ключей с помощью команды 'source script/src.tcl'
		1.5.0 Используя команду 'src script/fht.tcl -c' (или без ключа если компиляция не нужна), тоже самое при запуске через 'quartus_sh' (раб. директория должна быть директория репозитория)

	1.6 Перед компиляцией и запуском тестов проверить что файл define записался корректно

***

2. Запуск testbench:

	2.1 Запустить 'fht.m' в matlab, выбрав тип теста, сгенерируются файлы мат. модели преобразования для сравнения с RTL (addr RD/WR, состояние RAM на всех этапах и т.д.)

	2.2 Проверка миксеров требует включения опции в 'fht_defines.v' и использования теста 'test = num' или 'test = const'

	2.3 Запустить '.do' файл в modelsim, выставив перед этим настройки breakpoint и выводимых сообщений через 'fht_defines.v'

***

3. Использование полученного RTL:

	3.1 Заполнить RAM отсчетами (точки можно писать сразу во все банки через битреверсный счетчик банков)

	3.2 Выдать строб Start и ожидать Ready

	3.3 Считать готовые данные из RAM (можно также считывать 4 банка одновременно), учитывая что номера точек в банках имеют битреверсный порядок

---

### Замечания ###

---

* Разобраться с переполнением в бабочке (в конце получается общий делитель 4 * W_MAX, а не 2 * W_MAX)

* Входные данные заносятся через битреверсный счётчик банков, т.е. порядок не 0,1,2,3, а 0,2,1,3

* Входные/выходные порты 'top' модуля:
для более быстрой обработки полученных данных - на входе и выходе точки подаются из всех банков памяти одновременно

* Sin, Cos коэффициенты требуют держать в памяти только четверть периода, остальная часть вычисляется либо симметрией,
либо меняется знак, поэтому кол-во слов в ROM в 4 раза меньше, чем в одном банке, т.е. если шина адреса для RAM
"[A_BIT - 1 : 0]", то для ROM это будет "[A_BIT - 3 : 0]"

***

* Перенести вычисление коэффициентов из блока ROM в блок BUT
* Проверить даёт ли бит расширения для коэффициентов требуемую точность выше, чем если бы его не было и диапазон использовался не симметричный
* Сделать заполнение буфера до Nx точек в tb, остальное нули
* Влияние W_BIT, N на погрешность
* Требуется обновить QSYS в соответствии с TCL

---