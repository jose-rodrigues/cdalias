CDALIAS
=======

Introduction
------------
cdalias is a set of functions to help you to create cd aliases easily.

Install
-------
Zsh:

	git clone https://github.com/jose-rodrigues/cdalias.git ~/.cdalias && echo 'source $HOME/.cdalias/cdalias.sh' >> ~/.zshrc && source ~/.zshrc

Bash:

	git clone https://github.com/jose-rodrigues/cdalias.git ~/.cdalias && echo 'source $HOME/.cdalias/cdalias.sh' >> ~/.bashrc && source ~/.bashrc

Use
---
Create an alias:

	$ cdalias new aliasname ~/some/long/path/directory

Then juste type `cdaliasname` tu use the alias.

Update an alias:

	$ cdalias update aliasname ~/some/long/path/directory

Delete an alias:

	$ cdalias delete aliasname

Show all the aliases

	$ cdalias show
