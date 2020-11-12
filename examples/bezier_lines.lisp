(defpackage :raylib-user
  (:use :cl :raylib))

(in-package :raylib-user)

(defun main ()
  (let* ((screen-width 800)
         (screen-height 450)
         (title "raylib [shapes] example - cubic-bezier lines")
         (start (make-vector2 :x 0.0 :y 0.0))
         (end (make-vector2 :x (float screen-width) :y (float screen-height))))
    (with-window (screen-width screen-height title)
      (loop until (window-should-close)

            when (is-mouse-button-down +mouse-left-button+) do
              (setf start (get-mouse-position))
            when (is-mouse-button-down +mouse-right-button+) do
              (setf end (get-mouse-position))

            do
               (with-drawing
                 (clear-background +raywhite+)

                 (draw-text "USE MOUSE LEFT-RIGHT CLICK to DEFINE LINE START and END POINTS" 15 20 20 +gray+)

                 (draw-line-bezier start end 2.0 +red+))))))
