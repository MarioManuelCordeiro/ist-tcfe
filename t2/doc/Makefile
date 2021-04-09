# ---------------------------------------------------------
# type "make" command in Unix to create report.pdf 
# ---------------------------------------------------------

#list of LibreOffice Draw files
FILE=report
LODFIGS = $(patsubst %.odg,%.pdf,$(wildcard *.odg))

all: $(FILE).pdf
	evince $< &

Data.txt: ../t2_datagen.py
	python2 $< > $@
	
ngspice: ngspice_1 ngspice_2 ngspice_3 ngspice_4

$(FILE).pdf: $(wildcard *.tex) $(LODFIGS) octave.log ngspice
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex

octave.log: Data.txt
	octave ../mat/testar_téorico.m
	octave ../mat/Testar_coisas.m

../mat/octave.log: Data.txt
	make -C ../mat
	
ngspice_1: ngspice_1.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_1_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

ngspice_1.log: ../sim/t2_a.net
	ngspice -b $< -o $@
	
ngspice_2: ngspice_2.log
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_2_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

ngspice_2.log: ../sim/t2_b.net
	ngspice -b $< -o $@


ngspice_3: ngspice_3.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	
ngspice_3.log: ../sim/t2_c.net
	ngspice -b $< -o $@
	
ngspice_4: ngspice_4.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	
ngspice_4.log: ../sim/t2_d.net
	ngspice -b $< -o $@	

#convert libreoffice draw figures to pdf
%.pdf: %.odg
	soffice --headless --convert-to pdf $<

clean:
	@rm -rf *.aux *.bbl *.blg *.glg *.glo *.gls *.ilg *.ist *.lof
	@rm -rf *.log *.lot *.nlo *.nls *.out *.toc *~ *.*% ./*.pdf ./*.ps
	@rm -rf *_tab.tex octave-workspace *.eps
	@rm -rf *Ix.tex *voltages1.tex *voltages2.tex *v3_mag.tex *v3_ph.tex *Data.txt
	@rm -rf *diferenca_tensao.txt *circuit_data_1.cir *circuit_data_2.cir *circuit_data_3.cir *circuit_data_4.cir *currents1.tex *diferenca_tensao.tex *octave_constants_t_2.tex *octave_theorical_current_values_in_negative_time.tex *octave_theorical_current_values_in_zero_time.tex *octave_theorical_voltage_forced.tex *octave_theorical_voltage_values_in_negative_time.tex *octave_theorical_voltage_values_in_zero_time.tex

.PHONY: all clean Data.txt ngspice octave
