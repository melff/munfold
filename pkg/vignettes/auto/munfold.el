(TeX-add-style-hook
 "munfold"
 (lambda ()
   (setq TeX-command-extra-options
         "-shell-escape")
   (LaTeX-add-bibitems
    "schoenemann:metric.unfolding"))
 '(or :bibtex :latex))

