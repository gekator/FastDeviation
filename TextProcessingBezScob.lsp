(defun find_number(a /)
;a - текст
;Находит число на второй строке (факт) (setq a "500\\X600")(find_number a)
  ;(setq a "3.993\\P{\\C7;4.006}")(find_number a)
  ;(setq a "3.993\\P{\\C256;\\c0;4.012}")(find_number a)
  ;(setq a  "X=1446127.852\\PY=655971.131")
	(setq iz 1)
	(setq xz 1)
	(setq l (strlen a))
  (if (= (substr a iz 2) "X=")
    (setq iz (+ iz 1))
  )
	(while ( and (and (/= (substr a iz 1) "X") (/= (substr a iz 1) "P")) (< iz l))
		(setq iz (+ iz 1))
	)
	(while  (< xz l)
		(setq xz (+ xz 1))
	)
	(setq len (- xz iz))
	(setq st (substr a (+ iz 1) len))
  (cond
    ((/= (substr st 1 1) "{")
      (substr a (+ iz 1) len)
    )
    
    ((= (substr st 1 1) "{")
      (find_number_in_color st)
    )
  )
)

(defun find_number_in_color(a / iv xv v len )
;a - текст
;Находит число внутри скобок 500/X(600)
  ;(setq a "{\\C256;\\c0;4.012}")
	(setq iv 1)
	(setq xv 1)
	(setq v (strlen a))
	(while  (< iv v)
		
    (if (= (substr a iv 1) ";")
      (setq mx iv)
      (princ (strcat (substr a iv 1) "\n"))
    )
   (setq iv (+ iv 1))
	)
	(while ( and (/= (substr a xv 1) "}") (< xv v))
		(setq xv (+ xv 1))
	)
	(setq len (- xv mx))
	(substr a (+ mx 1) (- len 1))
)

(defun find_num_before(a / iz l xz)
	;добавил подсчет не больше длины строки и вывод текста без переноса строки 23.03.2020
  ;a - текст
  ;Находит число перед скобками 500/X(600)
	(setq xz 1)
	(setq l (strlen a))
  (setq iz 1)
  (setq start 0)
  (setq start (firstint a))
  (if (> l 1)
      (progn
	      (while (and (/= (substr a iz 1) "\\" ) (< iz l))
		    (setq iz (+ iz 1))
	    )
    )
  )
  (print iz)(print start)
  
 (cond
   ((and (= iz l) (< start iz)) (substr a start (- iz (- start 1))))
   ;((and (= iz l) (< start iz)) (strcat "")) 
   ((and (/= iz l) (< start iz)) (substr a start (- iz start)))
   ((and (/= iz l) (> start iz)) (strcat ""))
   ((= l 1) (strcat "" a))
  )
)

(defun getProjectElevFromItemTp(Proper)
  ;Proper - список
	;Возвращает текст из объекта
	
	(setq nameOfItem (cdr(assoc 0 Proper)))
	(cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(cdr(assoc 304 Proper))
			)
		)
		((= nameOfItem "TEXT")
			(cdr(assoc 1 Proper))
		)
	);end cond
)

(defun getProjectElevFromItemFp(Propy)
	;Возвращает число из объекта
	(setq nameOfItem (cdr(assoc 0 Propy)))
	(cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq n (cdr(assoc 304 Propy)))
				(print n)
				;(setq n (find_num_before n))
				(atof n)
			));
	 	((= nameOfItem "TEXT")
			(progn
				(setq Number3 (cdr(assoc 1 Propy)))
				(atof Number3)
			));
	)
);end defun

(defun getProjectElevFromItemProect(Propy)
	;Возвращает десятичное число перед скобками
	(setq nameOfItem (cdr(assoc 0 Propy)))
	(cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq n (cdr(assoc 304 Propy)))
				(setq n (find_num_before n))
				(atof n)
			));
	 	((or (= nameOfItem "TEXT") (= nameOfItem "DIMENSION"))
			(progn
				(setq Number3 (cdr(assoc 1 Propy)))
        (setq Number3 (find_num_before Number3))
				(atof Number3)
			));
	)
)

(defun getProjectElevFromItemProectText(Propy)
  ;!!!!!!!!!!!!!!!!!!!!!!!Проверено!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!24.03.21
	;Возвращает  число перед скобками в виде теста
	(setq nameOfItem (cdr(assoc 0 Propy)))
	(cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq n (cdr(assoc 304 Propy)))
				(setq n (find_num_before n))
			));
	 	((or (= nameOfItem "TEXT") (= nameOfItem "DIMENSION"))
			(progn
				(setq Number3 (cdr(assoc 1 Propy)))
        (setq Number3 (find_num_before Number3))
			));
	)
)

(defun getIntProjectElevation (Propy / nameOfItem n Number3 )
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!newwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	;Возвращает  число перед скобками  , для мультивыносок умножает на 1000, чтоб получить целое число 3.512 будет 3512
	(setq nameOfItem (cdr(assoc 0 Propy))); (setq nameOfItem (cdr(assoc 0 PropyList)))
	(cond
		((= nameOfItem "MULTILEADER")
			(progn
				(setq n (cdr(assoc 304 Propy)))
				(setq n (find_num_before n));(find_num_before "\X(505)")
        (cond
          ((= n "")
            (strcat "")
           )
          ((/= n "")
            (* 1000 (atof n))
          ) 
        )
      )
		)
   
    ((= nameOfItem "TEXT")
			(progn
				(setq n (cdr(assoc 1 Propy)))
				(setq n (find_num_before n));(find_num_before "\X(505)")
        (cond
          ((= n "")
            (strcat "")
           )
          ((/= n "")
            (* 1000 (atof n))
          ) 
        )
      )
		)
  ;
	 	(  (= nameOfItem "DIMENSION")
			(progn
				(setq Number3 (cdr(assoc 1 Propy)));(setq Number3 (cdr(assoc 1 PropyList)))
        (setq Number3 (find_num_before Number3))
        (cond
          ((= Number3 "")
            (strcat "")
           )
          ((/= Number3 "")
            (atof Number3)
          ) 
        )
        
			)
    );
	)
)

(defun getIntFactElevation (Propy / nameOfItem n Number3)
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!newwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	;Возвращает  факт  , для мультивыносок умножает на 1000, чтоб получить целое число 3.512 будет 3512
	(setq nameOfItem (cdr(assoc 0 Propy)))
	(cond
		((= nameOfItem "MULTILEADER")
			(progn
				(setq n (cdr(assoc 304 Propy)))
				(setq n (find_number n))
        (* 1000 (atof n))
			));
	 	((or (= nameOfItem "TEXT") (= nameOfItem "DIMENSION"))
			(progn
				(setq Number3 (cdr(assoc 1 Propy)))
        (setq Number3 (find_number Number3))
        (atof Number3)
			));
	)
)

(defun getProjectElevFromItemFactText(Propy)
  ;!!!!!!!!!!!!!!!!!!!!!!!Проверено!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!24.03.21
	;Возвращает  число в скобках в виде теста
	(setq nameOfItem (cdr(assoc 0 Propy)))
	(cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq n (cdr(assoc 304 Propy)))
				(setq n (find_number n))
			));
	 	((or (= nameOfItem "TEXT") (= nameOfItem "DIMENSION"))
			(progn
				(setq Number3 (cdr(assoc 1 Propy)))
        (setq Number3 (find_number Number3))
			));
	)
)



(defun changeItemSmart (PropItem  fNum / per nameOfItem)
  ;Умное изменение объектов, нужно дополнить для двух частей текста
  ;принимает готовый к вводу текст
  (setq nameOfItem (cdr(assoc 0 PropItem)))
  (setq per 0)
  (cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq per 304)
			)
		)
		((or (= nameOfItem "TEXT") (= nameOfItem "DIMENSION") (= nameOfItem "MTEXT"))
			(setq per 1)
		)
	);end cond
	(setq PropItem (subst (cons per fNum) (assoc per PropItem) PropItem))
	;(setq PropItem (subst (cons 62 1) (assoc 62 PropItem) PropItem))
	(entmod PropItem)
)


(defun changeItemColor (PropItem  col )
  (setq PropItem (subst (cons 62 col) (assoc 62 PropItem) PropItem))
	(entmod PropItem)
)
  

(defun changeItemElevation (PropItem  fNum col / per nameOfItem)
  ;Умное изменение объектов, нужно дополнить для двух частей текста
  ;принимает готовый к вводу текст
  (setq nameOfItem (cdr(assoc 0 PropItem)))
  (setq per 0)
  (cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq per 10)
			)
		)
		((or (= nameOfItem "TEXT") (= nameOfItem "POINT") (= nameOfItem "MTEXT"))
			(setq per 10)
		)
	);end cond
	(setq PropItem (subst (cons per fNum) (assoc per PropItem) PropItem))
	(setq PropItem (subst (cons 62 col) (assoc 62 PropItem) PropItem))
	(entmod PropItem)
)

(defun changeItemSmartColor (PropItem  fNum / per nameOfItem)
  ;Умное изменение объектов, нужно дополнить для двух частей текста
  ;принимает готовый к вводу текст
  (setq nameOfItem (cdr(assoc 0 PropItem)))
  (setq per 0)
  (cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq per 304)
			)
		)
		((or (= nameOfItem "TEXT") (= nameOfItem "DIMENSION") (= nameOfItem "MTEXT"))
			(setq per 1)
		)
	);end cond
  (princ PropItem)
	(setq PropItem (subst (cons per fNum) (assoc per PropItem) PropItem))
  ;(setq PropItem (subst (cons 62 4) (assoc 62 PropItem) PropItem))
	;(setq PropItem (subst (cons 62 2) (assoc 62 PropItem) PropItem))
  (princ PropItem)
	(entmod PropItem)
)

(defun PutProjectFactInItem ( Proper proreal factreal /  nameOfItem )
  ;Преобразовывает данные в соответствии с форматом потом закидывает их в объект
  ;
  (setq nameOfItem (cdr(assoc 0 Proper)));Number_pr 
  (cond 
		((or (= nameOfItem "TEXT") (= nameOfItem "MULTILEADER"))
			(progn
        (cond
          ((= proreal "")
            (strcat "")
           )
          ((/= proreal "")
            (setq projText (rtos (/ proreal 1000.0) 2 3))
          ) 
        )
				  
          (setq factText (rtos (/ factreal 1000.0) 2 3))
			)
		)
		((= nameOfItem "DIMENSION") 
			(progn
        (cond
          ((= proreal ""); (= Number_pr "")
            (setq projText "")
           )
          ((/= proreal "")
            (setq projText (rtos proreal 2 0))
          ) 
        )
				
        (setq factText (rtos factreal 2 0))
			)
		)
	);end cond
   
  (changeItemSmartProectFact Proper projText factText) ;записываем!!!!!!!!!!!!!
)

(defun PutProjectFactInItemCol ( Proper proreal factreal /  nameOfItem )
  ;Преобразовывает данные в соответствии с форматом потом закидывает их в объект
  ;
  (setq nameOfItem (cdr(assoc 0 Proper)));Number_pr 
  (cond 
		((or (= nameOfItem "TEXT") (= nameOfItem "MULTILEADER"))
			(progn
        (cond
          ((= proreal "")
            (strcat "")
           )
          ((/= proreal "")
            (setq projText (rtos (/ proreal 1000.0) 2 3))
          ) 
        )
				  
          (setq factText (rtos (/ factreal 1000.0) 2 3))
			)
		)
		((= nameOfItem "DIMENSION") 
			(progn
        (cond
          ((= proreal ""); (= Number_pr "")
            (setq projText "")
           )
          ((/= proreal "")
            (setq projText (rtos proreal 2 0))
          ) 
        )
				
        (setq factText (rtos factreal 2 0))
			)
		)
	);end cond
  (setq factText (strcat "{\\C7;" factText "}"))
  (changeItemSmartProectFact Proper projText factText) ;записываем!!!!!!!!!!!!!
)

(defun changeItemSmartProectFact (PropItem  pro fact / per razd)
  ;Умное изменение объектов, для проекта и факта
  ;принимает готовый к вводу текст
  (setq nameOfItem (cdr(assoc 0 PropItem)))
  (setq per 0)
  (setq textin "")
  (setq sign_plus "")
  (if ( = (strlen fact) 0)
    (setq razd "")
  )
  (cond 
		((and (= nameOfItem "MULTILEADER") (/= (strlen fact) 0))
			(progn
				(setq per 304)
        (setq textOfMultilidear (getProjectElevFromItemFactText PropItem))
        (if ( = (substr textOfMultilidear 1 1) "+") (setq sign_plus "+"))
        (setq textin (strcat sign_plus pro "\\P" sign_plus fact ""))
			)
		)
		((and (or  (= nameOfItem "DIMENSION") (= nameOfItem "MTEXT")) )
			(setq per 1)
      (setq textin (strcat pro "\\X" fact ""))
		)
    
    ((and (= nameOfItem "TEXT") (/= (strlen fact) 0))
			(setq per 1)
     (princ "00000=")
     (princ fact)
     (princ "  =")
      (setq textin fact)
		)
    
    ((and (= nameOfItem "MULTILEADER") (= (strlen fact) 0))
			(setq per 304)
      (setq textin pro)
		)
    
    ((and (= nameOfItem "TEXT") (= (strlen fact) 0))
			(setq per 1)
      (setq textin pro)
		)
	);end cond
	(setq PropItem (subst (cons per textin) (assoc per PropItem) PropItem))
	;(setq PropItem (subst (cons 62 2) (assoc 62 PropItem) PropItem))
	(entmod PropItem)
)




(defun isstr (a)
   (if (= (type a) 'STR)   
     T                     
     nil
   )
)



  
  (defun firstint(a / i)
    (setq i 1)
    (while (or 
              (< (ascii 
                  (substr a i 1)
              ) 
              48)
              (> (ascii 
                  (substr a i 1)
              ) 
              57)
            )
      (setq i (+ i 1))
    )
    (+ i)
  )


(defun return_mean(myss / PropertyList ss1)
	(setq ss1 myss)
	(princ (sslength ss1))
	(setq i 0)
	(setq x 0 )
	(setq z 0)
	(while (< i (sslength ss1))
		(setq Prop (entget(ssname ss1 i)))
		(setq Number (getProjectElevFromItemFp Prop))
	  (setq x (+ x Number))
	  (setq z (+ z 1))
	  (setq i (+ i 1))
		;
	)

  (/ x (float z) )
	
)



;;; ************************************************************************
;;; * Библиотека DWGruLispLib Copyright ©2007  DWGru Programmers Group
;;; *
;;; * _dwgru-random
;;; *
;;;  На основе vk_RandNum
;;;  http://www.caduser.ru/forum/index.ph...D=23&TID=32763
;;; *
;;; *
;;; * 07/12/2007 Версия 0001.  Редакция Владимир Азарко (VVA)
;;; ************************************************************************
(defun _dwgru-random (/ modulus multiplier increment)
;;; Генерирует случайное вещественное число в диапазоне от 0 до 1
;;; Используется глобальная переменная *DWGRU_SEED*
  (if (not *DWGRU_SEED*)
    (setq *DWGRU_SEED* (getvar "DATE"))
  )
  (setq  modulus     65536
  multiplier 25173
  increment  13849
  *DWGRU_SEED*     (rem (+ (* multiplier *DWGRU_SEED*) increment) modulus))
  (/ *DWGRU_SEED* modulus)
)
 
;;; ************************************************************************
;;; * Библиотека DWGruLispLib Copyright ©2007  DWGru Programmers Group
;;; *
;;; * dwgru-random-range
;;; *
;;; * 07/12/2007 Версия 0001.  Редакция Владимир Азарко (VVA)
;;; ************************************************************************
(defun dwgru-random-range (Minnum Maxnum )
;;; Генерирует случайное число из указанного диапазона целых чисел
;;; Использует функцию библиотеки
    ;;;                 _dwgru-random
    ;;; Параметры: 
    ;;; Minnum - минимальное целое число
    ;;; Maxnum - максимальное целое число
    ;;; Возврат:
    ;;;   целое число из указанного диапазона
 
    ;;; Пример:
  ;|
  (DWGRU-NUM-RANDOM-RANGE 1 15) ;_Результат 3
  (DWGRU-NUM-RANDOM-RANGE 1 15) ;_Результат 10
  |;
;(- Maxnum (atoi (rtos (* (- Maxnum Minnum) (_dwgru-num-random)) 2 0))) ;_Comment VVA 07.12.2007 Было так
;;;Comment VVA http://forum.dwg.ru/showpost.php?p=798277&postcount=9
;;;(- Maxnum (fix (* (- Maxnum Minnum) (_dwgru-random)))) ;_Add VVA 07.12.2007 Так наверное быстрее
;;;
(- Maxnum (fix (* (- Maxnum Minnum -1) (_dwgru-random)))) ;;;Vov.ka http://forum.dwg.ru/showpost.php?p=798277&postcount=9
)


