PY_SOURCES= \
	gateways2miners.py \
	src/messages.py \
	src/modify_rxpk.py \
	src/vgateway.py

DESTROOT?= /home/ftmiddle

install: run.sh ftmiddle.service $(PY_SOURCES)
	mkdir -p $(DESTROOT)
	mkdir -p $(DESTROOT)/src
	mkdir -p $(DESTROOT)/configs
	for pysrc in $(PY_SOURCES); do \
		install $$pysrc $(DESTROOT)/$$pysrc; \
	done
	install run.sh $(DESTROOT)
	install ftmiddle.service /etc/systemd/system
	install gw_configs/conf1.json $(DESTROOT)/configs
	install gw_configs/conf2.json $(DESTROOT)/configs
	install gw_configs/conf3.json $(DESTROOT)/configs
	install gw_configs/conf4.json $(DESTROOT)/configs
	install gw_configs/conf5.json $(DESTROOT)/configs
	install gw_configs/conf6.json $(DESTROOT)/configs
	install gw_configs/conf7.json $(DESTROOT)/configs
	install gw_configs/conf8.json $(DESTROOT)/configs
	install gw_configs/conf9.json $(DESTROOT)/configs

run.sh: run.sh.in
	sed -e s,@@DESTROOT@@,$(DESTROOT),g < $< > $@

ftmiddle.service: ftmiddle.service.in
	sed -e s,@@DESTROOT@@,$(DESTROOT),g < $< > $@
