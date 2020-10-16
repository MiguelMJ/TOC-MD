tocgen: src/tocgen.pl
	swipl --goal=main --stand_alone=true -o $@ -c $<
