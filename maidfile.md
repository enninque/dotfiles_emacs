## love
```bash
echo "I love you too :3"
```

## default
```bash
echo "A little more love :3"
```

## clean
```bash
rm -rfv ~/.emacs.d
```

## install
```bash
mkdir -p ~/.emacs.d
mkdir -p ~/.emacs.d/plugin
mkdir -p ~/.emacs.d/.save
mkdir -p ~/.local-data/.virtualenvs

cp -Rv src/.emacs.d   ~
cp -v src/.vikara.config.el ~
[ ! -d ~/.emacs.d/core/nyamacs ] && git clone "https://github.com/raisatu/nyamacs-lib" ~/.emacs.d/core/nyamacs
```
