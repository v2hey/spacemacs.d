;;http://emacsredux.com/blog/2013/03/26/smarter-open-line/
(defun zhanghe/smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))
