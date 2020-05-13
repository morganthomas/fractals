Dependencies: Futhark, Python, Pip

Steps:

```
pip install pypng
futhark c fractal.fut
echo '4096 4096' | ./fractal >mandelbrot.json
python mandelbrot.py
```
