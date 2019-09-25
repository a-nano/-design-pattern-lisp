```common-lisp
(ql:quickload :memento)

(setf gamer (memento:make-gamer 100))
(setf memento (memento:create-memento gamer))

(dotimes (i 100)
	   (format t "====~A~%" i)
	   (format t "����~A" (memento:to-string gamer))
	   (memento:bet gamer)
	   (format t "��������~A�~�ɂȂ�܂����B~%" (memento:money gamer))
	   (if (> (memento:money gamer) (/ (memento:money memento) 2))
	       (progn (format t "�����ԑ������̂ŁA���݂̏�Ԃ�ۑ����Ă�����~%")
		      (setf memento (memento:create-memento gamer)))
	       (progn (format t "�����Ԍ������̂ŁA�ȑO�̏�Ԃɕ��A���悤~%")
		      (memento:restore-memento memento gamer))))

```