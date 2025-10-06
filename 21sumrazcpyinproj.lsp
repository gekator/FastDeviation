(defun C:21sumrazcpyinprojV02 ( / PropertyList x i Prop factText factText_two Number Prop_two sum pr Number3) ;сложить два факта, потом записать в другой + проектное значение
 	
  (setq x 0)
  
	(setq i 0)
  
	(while (setq Prop (entget (car (entsel))))
   
		(setq factText (getProjectElevFromItemFactText Prop))
   
		(setq Number (atoi factText))
   
		(print Number)
   
		(setq Prop_two (entget (car (entsel))))
   
		(setq factText_two (getProjectElevFromItemFactText Prop_two))
  
		(setq Number_two (atoi factText_two))
  
		(princ Number_two)
  
		(setq sum (itoa  (+ Number Number_two)))
  
		(princ sum)
  
		(setq PropyList (entget (car (entsel))))
  
		(setq Number3 (getProjectElevFromItemProectText PropyList))

		(setq pr  Number3)

    (changeItemSmartProectFact PropyList pr sum)
	)
)