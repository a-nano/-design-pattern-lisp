(in-package :list-factory)

;; ��̓I�ȕ��i�FHTML�̃����N��\���N���X
(defclass list-link (link) ())

(defmethod make-list-link ((caption string) (url string))
  (make-instance 'list-link :caption caption :url url))

(defmethod make-html ((list-link list-link))
  (format t "<li><a href=\"~A\">~A</a></li>~%"
	  (url list-link)
	  (caption list-link)))

;; ��̓I�ȕ��i�FLink��Tray���W�߂��N���X
(defclass list-tray (tray) ())

(defmethod make-list-tray ((caption string))
  (make-instance 'list-tray :caption caption))

(defmethod make-html ((list-tray list-tray))
  (format t "<li>~%~A~%<ul>~%" (caption list-tray))
  (mapc #'make-html (tray list-tray))
  (format t "</ul>~%</li>~%"))

;; ��̓I�ȕ��i�FHTML�̃y�[�W��\���N���X
(defclass  list-page (page) ())

(defmethod make-list-page ((title string) (author string))
  (make-instance 'list-page :title title :author author))

(defmethod make-html ((list-page list-page))
  (format t "<html><head><title>~A</title></head>~%<body>~%<h1>~A</h1><ul>~%" (title list-page) (title list-page))
  (mapc #'make-html (content list-page))
  (format t "</ul>~%<hr><address>~A</address></body></html>~%" (author list-page)))

;; ��̓I�ȍH���\���N���X(ListLink, ListTray, ListPage�����)
(defclass list-factory (factory) ())

(defmethod create-link ((caption string) (url string) (list-factory list-factory))
  (make-list-link caption url))

(defmethod create-tray ((caption string) (list-factory list-factory))
  (make-list-tray caption))

(defmethod create-page ((title string) (author string) (list-factory list-factory))
  (make-list-page title author))
