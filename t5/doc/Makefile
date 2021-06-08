# ---------------------------------------------------------
# type "make" command in Unix to create report.pdf 
# ---------------------------------------------------------

#list of LibreOffice Draw files
FILE=report5
LODFIGS = $(patsubst %.odg,%.pdf,$(wildcard *.odg))

all: $(FILE).pdf
	evince $< &
	
ngspice: ngspice_1 ngspice_2

$(FILE).pdf: $(wildcard *.tex) $(LODFIGS) octave.log ngspice
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex

octave.log: Data.txt
	octave ../mat/t4.m
	

../mat/octave.log: Data.txt
	make -C ../mat
	
ngspice_1: ngspice_1.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_1_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

ngspice_1.log: ../sim/t41.net
	ngspice -b $< -o $@
	
ngspice_2: ngspice_2.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_2_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

ngspice_2.log: ../sim/t41_out_imp.net
	ngspice -b $< -o $@


#convert libreoffice draw figures to pdf
%.pdf: %.odg
	soffice --headless --convert-to pdf $<

clean:
	@rm -rf *.aux *.bbl *.blg *.glg *.glo *.gls *.ilg *.ist *.lof
	@rm -rf *.log *.lot *.nlo *.nls *.out *.toc *~ *.*% ./*.pdf ./*.ps
	@rm -rf *_tab.tex octave-workspace *.eps *octave_Constants_used_t_4.tex *octave_OP_t_4.tex *octave_results_t_4.tex

.PHONY: all clean Data.txt ngspice octave
