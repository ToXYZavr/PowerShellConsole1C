﻿
// Обработать нажатии не кнопку "Выполнить".
&НаКлиенте
Процедура ВыполнитьСкрипт(Команда)
	
	//первичные настройки и проверки.
	
	РезультатВыполненияСкрипта="";
	
	если ТекстСкрипта = "" тогда
		
		Сообщить("Текст скрипта не определен.");
		
		Возврат;
		
	КонецЕсли;
		
	Попытка
		
		PowerShellCOM = Новый COMОбъект("WScript.Shell"); // подключаем COM объект WScript.Shell
		
	исключение
		
		Сообщить("Не удалось создать COM объект WScript.Shell. " + ОписаниеОшибки());
		
		Возврат;
		
	КонецПопытки;	
	
	ТекстСкриптаПолный = "PowerShell -executionpolicy unrestricted -Command """;
	
	ТекстСкриптаПолный = ТекстСкриптаПолный + ТекстСкрипта+"""";
	
	ВыполнениеСкрипта=PowerShellCOM.Exec(ТекстСкриптаПолный);
	
	Sleep(3);
	
	ВыходнойПоток=ВыполнениеСкрипта.StdOut;
	
	пока НЕ ВыходнойПоток.AtEndOfStream цикл
		
		РезультатВыполненияСкрипта = РезультатВыполненияСкрипта + ВыходнойПоток.ReadLine() + Символы.ПС;
		
	КонецЦикла;
	
	ВыполнениеСкрипта.Terminate();
	
	PowerShellCOM = Неопределено;
	
	ЭтаФорма.Активизировать();
	
КонецПроцедуры

// Задержка (пауза) на <сек> сеунд.
&НаКлиенте
процедура Sleep(сек)
	
	КонДата = ТекущаяДата() + сек;
	
	Пока ТекущаяДата() < КонДата Цикл
		
	КонецЦикла;	
	
КонецПроцедуры

// При открытии формы заполняем поле Текст скрипта примером.
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекстСкрипта="foreach ($x in [System.Data.OleDb.OleDbEnumerator]::GetRootEnumerator()) {'{0,-30} {1,-60}' -f $x.Item(0), $x.Item(2)}";
	
КонецПроцедуры
