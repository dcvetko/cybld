.PHONY: install develop reqs reqs-dev sys-reqs sys-reqs-dev test docs tox clean

C=\033[32;01m
N=\033[0m

help:
	@echo "*****************************************"
	@echo "             $(C)cybld Makefile${N}"
	@echo "*****************************************"
	@echo
	@echo "$(C)install$(N)        Install cybld via setup.py install"
	@echo "$(C)develop$(N)        Install cybld via setup.py develop --user"
	@echo "$(C)reqs$(N)           Installs (optional) requirements via pip --user"
	@echo "$(C)reqs-dev$(N)       Installs development requirements via pip --user"
	@echo "$(C)sys-reqs$(N)       Installs (optional) requirements via pip (system-wide)"
	@echo "$(C)sys-reqs-dev$(N)   Installs development requirements via pip (system-wide)"
	@echo "$(C)test$(N)           Test cybld via tox"
	@echo "$(C)docs$(N)           Build the documentation via sphinx"
	@echo "$(C)clean$(N)          Remove build, dist and egg dirs"

HAS_PYTHON3  = $(shell command -v python3 2> /dev/null)
HAS_PYTHON36 = $(shell command -v python3.6 2> /dev/null)
HAS_PYTHON35 = $(shell command -v python3.5 2> /dev/null)
HAS_PYTHON34 = $(shell command -v python3.4 2> /dev/null)

ifneq (, $(HAS_PYTHON3))
	PYTHON_EXEC ?= python3
	PIP_EXEC    ?= pip3
endif

ifneq (, $(HAS_PYTHON36))
	PYTHON_EXEC ?= python3.6
	PIP_EXEC    ?= pip3.6
endif

ifneq (, $(HAS_PYTHON35))
	PYTHON_EXEC ?= python3.5
	PIP_EXEC    ?= pip3.5
endif

ifneq (, $(HAS_PYTHON34))
	PYTHON_EXEC ?= python3.4
	PIP_EXEC    ?= pip3.4
endif

install:
	$(PYTHON_EXEC) setup.py install

develop:
	$(PYTHON_EXEC) setup.py develop --user

reqs:
	$(PIP_EXEC) install sphinx --user
	$(PIP_EXEC) install neovim --user

reqs-dev:
	$(PIP_EXEC) install tox --user
	$(PIP_EXEC) install flake8 --user
	$(PIP_EXEC) install pytest --user
	$(PIP_EXEC) install pytest-cov --user
	$(PIP_EXEC) install codecov --user

sys-reqs:
	$(PIP_EXEC) install sphinx
	$(PIP_EXEC) install neovim

sys-reqs-dev:
	$(PIP_EXEC) install tox
	$(PIP_EXEC) install flake8
	$(PIP_EXEC) install pytest
	$(PIP_EXEC) install pytest-cov
	$(PIP_EXEC) install codecov

test:
	tox

docs:
	cd docs && sphinx-apidoc -o build ../cybld && make html && make man

clean:
	-test -d build && rm -rf build
	-test -d dist && rm -rf dist
	-test -d cybld.egg-info && rm -rf cybld.egg-info
	-test -d docs/build && rm -rf docs/build
