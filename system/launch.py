import os, sys

generator = sys.argv[1]
solver = sys.argv[2]
outfile = "tmp.out.txt"
srcfile = "tmp.src.txt"

s = ""

for i in range(100):
    os.system("python3 " + generator + " > " + srcfile);
    os.system("python3 " + solver + " < " + srcfile + " > " + outfile)
    s += "Case=test" + str(i+1) + "\n" + "input="
    f = open(srcfile)
    for line in f:
        s += line
    f.close()

    s += "output="
    f = open(outfile)
    for line in f:
        s += line
    f.close()

os.remove(outfile)
os.remove(srcfile)
print(s, end='')
