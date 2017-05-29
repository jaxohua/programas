:- set_prolog_flag(double_quotes, chars).
:- use_module(library(double_quotes)).

compila():- working_directory(CWD,'/Users/4x/'),
            shell('pdflatex ax2.tex | open ax2.pdf').