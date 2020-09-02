.PHONY: workspace design compile prove clean

workspace:
	./workspace.sh


design: workspace
	./design.sh

compile: design
	./compile.sh

prove: compile
	./prove.sh

gui: prove
	./gui.sh

clean:
	./clean.sh
