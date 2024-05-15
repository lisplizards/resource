;; Copyright (c) 2024 John Newton
;; SPDX-License-Identifier: Apache-2.0

(in-package #:foo.lisp.resource/fast)

(defun url (object)
  (check-type foo.lisp.resource:*origin* string)
  (assert (and (> (length foo.lisp.resource:*origin*) 7)
               (or (string= "https://" (subseq foo.lisp.resource:*origin* 0 8))
                   (string= "http://" (subseq foo.lisp.resource:*origin* 0 7))))
          nil
          "*ORIGIN* must be a valid URL")
  (format nil "~A~A" foo.lisp.resource:*origin* (path object)))

(defun path (object)
  (let ((path (%path object)))
    (check-type path string)
    (unless (and (> (length path) 0)
                 (equal "/" (subseq path 0 1)))
      (error "Resource path must begin with a forward slash '/'"))
    path))

(defun dom-id (object &optional key)
  (if key
      (format nil "~A_~A" (%dom-id object) key)
      (%dom-id object)))

(defgeneric %path (object)
  (:generic-function-class fast-generic-functions:fast-generic-function)
  (:documentation
   "Generic function that returns a string representing the canonical path of the HTTP resource; a FAST-GENERIC-FUNCTION."))

(defgeneric %dom-id (object)
  (:generic-function-class fast-generic-functions:fast-generic-function)
  (:documentation "Returns a DOM ID string for the given object; a FAST-GENERIC-FUNCTION."))
