# Project utilities
env_create:
	conda create -n research_gps_activity_extraction python=3.10 -y

env_configure: env_install_dependencies env_install_jupyter_extensions env_install_precommit_hooks
	echo "Environment is configured"

env_install_precommit_hooks:
	pre-commit install && pre-commit install --hook-type commit-msg

env_install_dependencies:
	pip3 install --upgrade pip \
	&& pip3 install wheel \
	&& pip3 install poetry==1.2.2 \
	&& poetry install && pip3 install lightgbm==3.3.5

env_install_jupyter_extensions:
	jupyter contrib nbextension install --sys-prefix \
	&& jupyter nbextension install --user https://rawgithub.com/minrk/ipython_extensions/master/nbextensions/toc.js \
	&& jupyter nbextension enable --py widgetsnbextension \
	&& jupyter nbextension enable codefolding/main \
	&& jupyter nbextension enable spellchecker/main \
	&& jupyter nbextension enable toggle_all_line_numbers/main \
	&& jupyter nbextension enable hinterland/hinterland \
	&& jt -t oceans16

env_delete:
	conda remove --name research_gps_activity_extraction --all -y

run_jupyter:
	jupyter-notebook --ip 0.0.0.0 --no-browser

run_precommit:
	pre-commit run --all-files
