(defpackage :raylib-user
  (:use :cl :raylib))

(in-package :raylib-user)

(defun main ()
  (let* ((screen-width 800)
         (screen-height 450)
         (title "raylib [shapes] example - following eyes")
         (sclera-left-position (make-vector2 :x (- (/ screen-width 2) 100.0)
                                             :y (/ screen-height 2.0)))
         (sclera-right-position (make-vector2 :x (+ (/ screen-width 2) 100.0)
                                              :y (/ screen-height 2.0)))
         (iris-left-position (make-vector2 :x (- (/ screen-width 2) 100.0)
                                             :y (/ screen-height 2.0)))
         (iris-right-position (make-vector2 :x (+ (/ screen-width 2) 100.0)
                                              :y (/ screen-height 2.0)))
         (sclera-radius 80.0)
         (iris-radius 24.0))
    (with-window (screen-width screen-height title)
      (set-target-fps 60)

      (loop until (window-should-close)

            ;; do this every loop
            do (setf iris-left-position (get-mouse-position)
                     iris-right-position (get-mouse-position))

            ;; check if mouse is not inside left eye
            unless (check-collision-point-circle iris-left-position
                                                 sclera-left-position
                                                 (- sclera-radius 20))
              do (let* ((dx (- (vector2-x iris-left-position) (vector2-x sclera-left-position)))
                        (dy (- (vector2-y iris-left-position) (vector2-y sclera-left-position)))
                        (angle (float (atan dy dx)))
                        (dxx (* (cos angle) (- sclera-radius iris-radius)))
                        (dyy (* (sin angle) (- sclera-radius iris-radius))))
                   (setf (vector2-x iris-left-position) (+ dxx (vector2-x sclera-left-position))
                         (vector2-y iris-left-position) (+ dyy (vector2-y sclera-left-position))))

            ;; check if mouse is not inside right eye
            unless (check-collision-point-circle iris-right-position
                                                 sclera-right-position
                                                 (- sclera-radius 20))
              do (let* ((dx (- (vector2-x iris-right-position) (vector2-x sclera-right-position)))
                        (dy (- (vector2-y iris-right-position) (vector2-y sclera-right-position)))
                        (angle (float (atan dy dx)))
                        (dxx (* (cos angle) (- sclera-radius iris-radius)))
                        (dyy (* (sin angle) (- sclera-radius iris-radius))))
                   (setf (vector2-x iris-right-position) (+ dxx (vector2-x sclera-right-position))
                         (vector2-y iris-right-position) (+ dyy (vector2-y sclera-right-position))))

            ;; do our drawing
            do
               (with-drawing
                 (clear-background +raywhite+)
                 
                 (draw-circle-v sclera-left-position sclera-radius +lightgray+)
                 (draw-circle-v sclera-right-position sclera-radius +lightgray+)
                 
                 (draw-circle-v iris-left-position iris-radius +brown+)
                 (draw-circle-v iris-right-position iris-radius +darkgreen+)
                 
                 (draw-circle-v iris-left-position 10.0 +black+)
                 (draw-circle-v iris-right-position 10.0 +black+)

                 (draw-fps 10 10))))))
