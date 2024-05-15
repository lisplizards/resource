;; Copyright (c) 2024 John Newton
;; SPDX-License-Identifier: Apache-2.0

(in-package #:cl-user)

(defpackage #:foo.lisp.resource
  (:use #:cl)
  (:export #:*origin*)
  (:export #:resource-path-undefined
           #:dom-id-undefined)
  (:export #:url
           #:path
           #:dom-id)
  (:export #:%path
           #:%dom-id))

(defpackage #:foo.lisp.resource/fast
  (:use #:cl)
  (:export #:url
           #:path
           #:dom-id)
  (:export #:%path
           #:%dom-id))
