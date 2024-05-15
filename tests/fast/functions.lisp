;; Copyright (c) 2024 John Newton
;; SPDX-License-Identifier: Apache-2.0

(in-package #:foo.lisp.resource/tests/fast)

(defstruct widget
  id)

(defmethod foo.lisp.resource/fast:%path ((widget widget))
  (format nil "/widget/~A" (widget-id widget)))

(defmethod foo.lisp.resource/fast:%dom-id ((widget widget))
  (format nil "widget_~A" (widget-id widget)))

(fast-generic-functions:seal-domain #'foo.lisp.resource/fast:%path '(widget))

(fast-generic-functions:seal-domain #'foo.lisp.resource/fast:%dom-id '(widget))

(deftest test-path
    (testing "calling #'PATH results in the string returned from the specializer %PATH method"
             (let ((widget (make-widget :id "10E9E476-4360-4D3F-9E93-A4AAF831118D")))
               (ok (equal "/widget/10E9E476-4360-4D3F-9E93-A4AAF831118D"
                          (foo.lisp.resource/fast:path widget))))))

(deftest test-url
  (testing "calling #'URL results in the concatenation of the strings returned by *ORIGIN* and #'PATH"
           (let ((foo.lisp.resource:*origin* "http://acme.example.com")
                 (widget (make-widget :id "686307B9-A420-4F10-9D71-9061654B0E1E")))
             (ok (equal "http://acme.example.com/widget/686307B9-A420-4F10-9D71-9061654B0E1E"
                        (foo.lisp.resource/fast:url widget))))))

(deftest test-dom-id
    (testing "calling #'DOM-ID results in the string returned from the specializer %DOM-ID method"
             (let ((widget (make-widget :id "913E5BA9-48E8-45F9-B5ED-E88851ABF831")))
               (ok (equal "widget_913E5BA9-48E8-45F9-B5ED-E88851ABF831"
                          (foo.lisp.resource/fast:dom-id widget)))))

  (testing "calling #'DOM-ID with the optional parameter KEY results in the key as part of the ID string"
           (let ((widget (make-widget :id "5C8C1711-56DF-4CD0-93AF-42DEB2A6BAC2")))
             (ok (equal "widget_5C8C1711-56DF-4CD0-93AF-42DEB2A6BAC2_foo"
                        (foo.lisp.resource/fast:dom-id widget "foo"))))))
