;; Copyright (c) 2024 John Newton
;; SPDX-License-Identifier: Apache-2.0

(in-package #:foo.lisp.resource)

(defun url (object)
  (check-type *origin* string)
  (assert (and (> (length *origin*) 7)
               (or (string= "https://" (subseq *origin* 0 8))
                   (string= "http://" (subseq *origin* 0 7))))
          nil
          "*ORIGIN* must be a valid URL")
  (format nil "~A~A" *origin* (path object)))

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
  (:documentation "Generic function that returns a string representing the canonical path of the HTTP resource."))

(defgeneric %dom-id (object)
  (:documentation "Returns a DOM ID string for the given object."))

