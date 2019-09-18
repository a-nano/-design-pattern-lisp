(in-package :composite)

;; Folder��File�𓯈ꎋ����C���^�[�t�F�[�X
(defclass ientry () ())

(defgeneric output (depth instance))

;; �t�H���_��\���N���X
(defclass folder (ientry)
  ((name :accessor name :initform "" :initarg :name)
   (entries :accessor entries :initform () :initarg :entries)))

(defmethod make-folder ((name string))
  (make-instance 'folder :name name))

(defmethod output ((depth number) (folder folder))
  (dotimes (i depth) (princ " "))
  (format t "Folder:~A~%" (name folder))
  (mapc #'(lambda (entry) (output (1+ depth) entry))
	(entries folder)))

(defmethod add-entry ((entry ientry) (folder folder))
  (push entry (entries folder)))

;; �t�@�C����\���N���X
(defclass file (ientry)
  ((name :accessor name :initform "" :initarg :name)
   (entries :accessor entries :initform () :initarg :entries)))

(defmethod make-file ((name string))
  (make-instance 'file :name name))

(defmethod output ((depth number) (file file))
  (dotimes (i depth) (princ " "))
  (format t "File:~A~%" (name file)))
