(defpackage :raylib-user
  (:use :cl :raylib))

(in-package :raylib-user)

(defun main ()
  (let* ((screen-width 800)
         (screen-height 450)
         (title "raylib [shapes] example - collision area")
         (box-a (make-rectangle :x 10.0 :y (- (/ screen-height 2.0) 50)
                                :width 200.0 :height 100.0))
         (box-b (make-rectangle :x (- (/ screen-width 2.0) 30) :y (- (/ screen-height 2.0) 30)
                                :width 60.0 :height 60.0))
         (box-a-speed-x 4)
         (screen-upper-limit 40))
    (with-window (screen-width screen-height title)
      (set-target-fps 60)
      
      (loop with pause
            until (window-should-close)

            ;; pause the big box if we hit space
            when (is-key-pressed +key-space+)
              do (setf pause (not pause))

            unless pause
              do (incf (rectangle-x box-a) box-a-speed-x)

            ;; animate the large rectangle
            when (or (>= (+ (rectangle-x box-a) (rectangle-width box-a))
                         screen-width)
                     (<= (rectangle-x box-a) 0))
              do (setf box-a-speed-x (- box-a-speed-x))

            do
               (setf (rectangle-x box-b) (- (get-mouse-x) (/ (rectangle-width box-b) 2.0))
                     (rectangle-y box-b) (- (get-mouse-y) (/ (rectangle-height box-b) 2.0)))

               ;; dont let the user controlled box go out of the window
               (if (>= (+ (rectangle-x box-b) (rectangle-width box-b))
                       screen-width)
                   (setf (rectangle-x box-b) (- screen-width (rectangle-width box-b)))
                   (when (<= (rectangle-x box-b) 0)
                     (setf (rectangle-x box-b) 0)))
               (if (>= (+ (rectangle-y box-b) (rectangle-height box-b))
                       screen-height)
                   (setf (rectangle-y box-b) (- screen-height (rectangle-height box-b)))
                   (when (<= (rectangle-y box-b) screen-upper-limit)
                     (setf (rectangle-y box-b) screen-upper-limit)))

               (let* ((collision (check-collision-recs box-a box-b))
                      (box-collision (when collision (get-collision-rec box-a box-b))))

                 (with-drawing
                   (clear-background +raywhite+)

                   (draw-rectangle 0 0 screen-width screen-upper-limit (if collision +red+ +black+))

                   (draw-rectangle-rec box-a +gold+)
                   (draw-rectangle-rec box-b +blue+)

                   ;; when we have a collision we display information about it
                   (when collision
                     (draw-rectangle-rec box-collision +lime+)
                     (draw-text "COLLISION!"
                                (- (/ screen-width 2) (/ (measure-text "COLLISION!" 20) 2))
                                (- (/ screen-upper-limit 2) 10)
                                20 +black+)
                     (draw-text (format nil "Collision Area: ~a" (* (rectangle-width box-collision)
                                                                    (rectangle-height box-collision)))
                                (- (/ screen-width 2) 100)
                                (+ screen-upper-limit 10)
                                20 +black+))

                   (draw-fps 10 10)))))))
