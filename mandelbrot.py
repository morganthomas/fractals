import json
import png

json = json.load(open('mandelbrot.json', 'r'))
f = open('mandelbrot.png', 'wb')
w = png.Writer(4096, 4096, greyscale=True)
w.write(f, map(lambda row: map(lambda cell: 255 if cell else 0, row), json))
f.close()
