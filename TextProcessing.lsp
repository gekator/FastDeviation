
(defun find_number(a /)

	(setq iz 1)
	(setq xz 1)
	(setq l (strlen a))
	(while(/= (substr a iz 1) "(")
		(setq iz (+ iz 1))
	)
	(while(/= (substr a xz 1) ")")
		(setq xz (+ xz 1))
	)
	(setq len (- xz iz))
	(substr a (+ iz 1) (- len 1))
)

(defun getProjectElevFromItemTp(Proper)
	;Возвращает текст из скобок
	
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
	;Возвращает десятичное число из скобок
	(setq nameOfItem (cdr(assoc 0 Propy)))
	(cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq n (cdr(assoc 304 Propy)))
				(print n)
				(setq n (find_num_before n))
				(print n)
				(print "ura3")
				(atof n)
			));
	 	((= nameOfItem "TEXT")
			(progn
				(setq Number3 (cdr(assoc 1 Propy)))
				(print "text4")
				(atof Number3)
			));
	)
);end defun

(defun getProjectElevFromItemProect(Propy)
	;Возвращает десятичное число из скобок
	(setq nameOfItem (cdr(assoc 0 Propy)))
	(cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq n (cdr(assoc 304 Propy)))
				(print n)
				(setq n (find_num_before n))
				(print n)
				(print "ura3")
				(atof n)
			));
	 	((= nameOfItem "TEXT")
			(progn
				(setq Number3 (cdr(assoc 1 Propy)))
				(print "text4")
				(atof Number3)
			));
	)
)

(defun changeItemSmart (PropItem  fNum / per)
  (setq nameOfItem (cdr(assoc 0 PropItem)))
  (setq per 0)
  (cond 
		((= nameOfItem "MULTILEADER")
			(progn
				(setq per 304)
				
			)
		)
		((= nameOfItem "TEXT")
			(setq per 1)
		)
	);end cond
  
	(setq PropItem (subst (cons per fNum) (assoc per PropItem) PropItem))
	;(setq PropItem (subst (cons 62 2) (assoc 62 PropItem) PropItem))
	(entmod PropItem)
)


(defun find_num_before(a /)
	
	(setq iz 1)
	(setq xz 1)
	(setq l (strlen a))
	(while(/= (substr a iz 1) "\\" )
		(setq iz (+ iz 1))
	)
	(substr a 1 (- iz 1))
)